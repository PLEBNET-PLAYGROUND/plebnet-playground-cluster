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

def get_service(service_base, node_value, service_template, arch_value):
    result = OmegaConf.merge(
        OmegaConf.create({'n': node_value, 'ARCH': arch_value}),
        service_template)
    OmegaConf.resolve(result)
    result.pop('n')
    result.pop('ARCH')
    return result

from omegaconf import OmegaConf

cli_args = OmegaConf.from_cli()

try:
    arch = cli_args['ARCH']
except KeyError:
    print('Need to supply ARCH. Supported architectures:')
    for k, v in architectures.items():
        print('\t{}: ARCH={}'.format(k, v))
    sys.exit()

try:
    nodes = int(cli_args['nodes'])
except KeyError:
    print('Need to supply number of nodes: nodes=')
    sys.exit()

# node_numbers = dict()

# for _ in 'bitcoind_n', 'lnd_n', 'tor_n':
#     try:
#         node_numbers[_] = getattr(cli_args, _)
#     except:
#         print('Need to supply {}='.format(_))
#         sys.exit()

conf = OmegaConf.load('docker-compose.yaml.template')

# merge in architecture
conf = OmegaConf.merge(OmegaConf.create(dict(ARCH=arch)), conf)

print('creating config for nodes:')


for service_base in list(conf.services):
    print(service_base, nodes)
    for i in range(nodes):
        service_name = '{}-{}'.format(service_base, str(i))
        conf.services[service_name] = get_service(
            service_base,
            i,
            conf.services[service_base],
            arch)
        # remove build for additional nodes
        if i > 0:
            conf.services[service_name].pop('build')
    conf.services.pop(service_base)
try:
    OmegaConf.resolve(conf)
except:
    print(OmegaConf.to_yaml(conf))
    raise
conf.pop('ARCH')

with open('docker-compose.yaml', 'w') as f:
    f.write(OmegaConf.to_yaml(conf))
