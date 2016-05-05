#!/bin/bash

export server_certs=./certs/domain.crt
if [ ! -f $server_certs ] ; then
  echo File certs/domain.crt does not exist.
  exit 1
fi

if [ -f config ] ; then
  . config
else
  export DOMAIN=localhost
  export PORT=5000
fi

# Deploy clinet certificates
if [ -z "$PORT" ] ; then
  export certs=/etc/docker/certs.d/$DOMAIN
else
  export certs=/etc/docker/certs.d/$DOMAIN:$PORT
fi
sudo mkdir -p $certs
sudo openssl genrsa -out $certs/client.key 4096
sudo openssl req -new -x509 -text -key $certs/client.key -out $certs/client.cert -subj "/CN=$(hostname)$SUBJECT"
sudo cp $server_certs $certs
sudo service docker restart
