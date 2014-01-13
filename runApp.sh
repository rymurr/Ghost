#!/bin/bash

python getCreds.py
secret=`curl --key client.key --cert client.crt --cacert server.pem -L https://rymurr.com:4001/v2/keys/ghostAWSSecret -k|cut -d':' -f5|cut -d'"' -f2`
key=`curl --key client.key --cert client.crt --cacert server.pem -L https://rymurr.com:4001/v2/keys/ghostAWSKey -k|cut -d':' -f5|cut -d'"' -f2`
sed "s|AWS_SECRET_KEY|$secret|" config.js.template | sed "s|AWS_KEY_ID|$key|" >config.js
npm start

