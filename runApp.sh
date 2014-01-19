#!/bin/bash

#get server/client credentials from S3
python getCreds.py
#put this hostname into the list of backups, add the backup method
curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:$ETCDPORT/v2/keys/backups/$HOSTNAME -XPUT -d value=22 -k
#put this hostname in the ghost-ryan section of the hipache config
curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:$ETCDPORT/v2/keys/hipache/ghost-ryan/$HOSTNAME -XPUT -d value=2368 -k
#get SES config from etcd
secret=`curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:$ETCDPORT/v2/keys/ghostAWSSecret -k|cut -d':' -f5|cut -d'"' -f2`
key=`curl --key client.key --cert client.crt --cacert server.pem -L https://$ETCDHOST:$ETCDPORT/v2/keys/ghostAWSKey -k|cut -d':' -f5|cut -d'"' -f2`
#add SES config to config
sed "s|AWS_SECRET_KEY|$secret|" config.js.template | sed "s|AWS_KEY_ID|$key|" >config.js
#start ghost
/usr/sbin/sshd
npm start

