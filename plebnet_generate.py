# Generates docker-compose for n nodes.

# +
from omegaconf import OmegaConf
import sys


architectures = {
        "Intel x64": 'x86_64-linux-gnu',
        'OSX 64-bit': 'aarch64-linux-gnu',
        'arm 32-bit': 'arm-linux-gnueabihf',
        'ARM64 linux': 'aarch64-linux-gnu',
}

from omegaconf import OmegaConf

cli_args = OmegaConf.from_cli()

try:
    arch = cli_args['ARCH']
except KeyError:
    print('Need to supply ARCH. Supported architectures:')
    for k, v in architectures.items():
        print('\t{}: ARCH={}'.format(k, v))
    sys.exit()

node_counts = dict()

for _ in 'bitcoind', 'lnd', 'tor':
    try:
        node_counts[_] = getattr(cli_args, _)
    except:
        print('Need to supply {}='.format(_))
        sys.exit()

conf = OmegaConf.load('docker-compose.yaml.template')

# merge in architecture
conf = OmegaConf.merge(OmegaConf.create(dict(ARCH=arch)), conf)

print('creating config for nodes:')

def get_service(service_values, service_template):
    """merge values into template"""
    result = OmegaConf.merge(
        service_values,
        service_template)
    OmegaConf.resolve(result)
    for key in service_values:
        result.pop(key)
    return result

def get_service_values(i, node_counts, **kwargs):
    """Get service values using the modulus of service counts"""
    service_values = dict()
    for service, nodes in node_counts.items():
        service_values[service + '_i'] = i%node_counts[service]
    for k,v in kwargs.items():
        service_values[k] = v
    return OmegaConf.create(service_values)

for service, service_nodes in node_counts.items():
    print(service, service_nodes)
    for i in range(service_nodes):
        service_values = get_service_values(i, node_counts, ARCH=arch)
        service_name = '{}-{}'.format(service, str(i))
        conf.services[service_name] = get_service(
            service_values,
            conf.services[service])
        # remove build for additional nodes
        if i > 0:
            conf.services[service_name].pop('build')
    conf.services.pop(service)

dashboard = conf.services.pop('dashboard')
dashboard.links = []
dashboard.volumes = []
dashboard.volumes.append(OmegaConf.create({"type" : "bind", "source": f'${{oc.env:PWD}}/dashboard',"target":"/dashboard"}))
for service in 'lnd', 'bitcoind':
    for i in range(node_counts[service]):
        dashboard.links.append('{}-{}'.format(service, i))
dashboard.depends_on = dashboard.links
for i in range(node_counts['lnd']):
    lnd_conf = OmegaConf.create({"type" : "bind", "source": f'${{oc.env:PWD}}/volumes/lnd_datadir_{i}',"target":f'/root/.lnd/{i}/',"read_only":"true"})
    dashboard.volumes.append(lnd_conf)
conf.services['dashboard'] = dashboard

try:
    OmegaConf.resolve(conf)
except:
    print(OmegaConf.to_yaml(conf))
    raise
conf.pop('ARCH')

with open('docker-compose.yaml', 'w') as f:
    f.write(OmegaConf.to_yaml(conf))
