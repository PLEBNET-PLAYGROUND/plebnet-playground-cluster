# Generates docker-compose for n nodes.

# +
from omegaconf import OmegaConf
import sys

def get_service(node_value, service_template, arch_value):
    result = OmegaConf.merge(
        OmegaConf.create(dict(n=node_value, ARCH=arch_value)),
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
    print('Need to supply ARCH, for example: ARCH=x86_64-linux-gnu')
    sys.exit()

node_numbers = dict()

for _ in 'bitcoind_n', 'lnd_n', 'tor_n':
    try:
        node_numbers[_] = getattr(cli_args, _)
    except:
        print('Need to supply {}='.format(_))
        sys.exit()

conf = OmegaConf.load('docker-compose.yaml.template')

conf = OmegaConf.merge(OmegaConf.create(dict(ARCH=arch)), conf)

print('creating config for nodes:')
for k, v in node_numbers.items():
    print('{}: {}'.format(k[:-2], v))
    for i in range(v):
        service_name = k.replace('_n', '-'+str(i))
        conf.services[service_name] = get_service(i, conf.services[k], arch)
    conf.services.pop(k)

OmegaConf.resolve(conf)
conf.pop('ARCH')

with open('docker-compose.yaml', 'w') as f:
    f.write(OmegaConf.to_yaml(conf))
