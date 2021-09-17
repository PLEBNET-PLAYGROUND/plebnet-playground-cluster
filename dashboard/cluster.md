# About

This directory contains setup necessary for creating dashboard visualizations of the lightning network

The grpc instructions are here https://github.com/lightningnetwork/lnd/blob/master/docs/grpc/python.md


## Accessing node graph data (node 0)

```python
import sys
sys.path.append('/grpc')
import codecs
import os
import grpc
import lightning_pb2 as lnrpc
import lightning_pb2_grpc as lightningstub
macaroon = codecs.encode(open('/root/.lnd/0/data/chain/bitcoin/signet/admin.macaroon', 'rb').read(), 'hex')
os.environ['GRPC_SSL_CIPHER_SUITES'] = 'HIGH+ECDSA'
cert = open('/root/.lnd/0/tls.cert', 'rb').read()
ssl_creds = grpc.ssl_channel_credentials(cert)
channel = grpc.secure_channel('playground-lnd-0:10009', ssl_creds)
stub = lightningstub.LightningStub(channel)
request = lnrpc.ChannelGraphRequest(include_unannounced=True)
response = stub.DescribeGraph(request, metadata=[('macaroon', macaroon)])

```

<!-- #region -->
Response is a object containing:
```python
# { 
#     "nodes": <array LightningNode>,
#     "edges": <array ChannelEdge>,
# }
```
<!-- #endregion -->

## nodes

```python
response.nodes[0]
```

## edges

```python
response.edges[0]
```

```python

```
