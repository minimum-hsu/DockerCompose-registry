#!/bin/bash

if [ -f config ] ; then
  . config
else
  export DOMAIN=localhost
fi

echo Domain is $DOMAIN

# Generate server certificates
export certs=./certs
mkdir -p $certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout $certs/domain.key -x509 -days 3650 -out $certs/domain.crt -subj "/CN=$DOMAIN$SUBJECT"
