#!/bin/bash

#get server/client credentials from S3
python getCreds.py
#put this hostname into the list of backups, add the backup method
curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:4001/v2/keys/backups/$HOSTNAME -XPUT -d value=sshd -k
#put this hostname in the ghost-cort section of the hipache config
curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:4001/v2/keys/hipache/ghost-cort/$HOSTNAME -XPUT -d value=$HOSTNAME -k|cut -d':' -f5|cut -d'"' -f2`
#get SES config from etcd
secret=`curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:4001/v2/keys/ghostAWSSecret -k|cut -d':' -f5|cut -d'"' -f2`
key=`curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:4001/v2/keys/ghostAWSKey -k|cut -d':' -f5|cut -d'"' -f2`
#add SES config to config
sed "s|AWS_SECRET_KEY|$secret|" config.js.template | sed "s|AWS_KEY_ID|$key|" >config.js
#start ghost
npm start

