#!/bin/bash
cd /etc/openvpn/certificates/
. ./vars
export KEY_CN=$@
./pkitool $KEY_CN
cp client.ovpn.default keys/$KEY_CN.conf
sed -i -s "s/LOGIN/$KEY_CN/g" keys/$KEY_CN.conf
mkdir keys/$KEY_CN
cp keys/ca.crt keys/$KEY_CN
mv keys/$KEY_CN.* keys/$KEY_CN
tar czfv ~/$KEY_CN.tar.gz keys/$KEY_CN
