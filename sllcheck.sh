echo "サーバ証明書>"
read -e server
echo "中間証明書>"
read -e ca
echo "秘密鍵>"
read -e key

echo -e "\n================================"
echo "サーバ証明書> $server"
echo "中間証明書> $ca"
echo "秘密鍵> $key"
echo "================================"
echo md5c Check.
server_md5=$(openssl x509 -noout -modulus -in $server | openssl md5)
key_md5=$(openssl rsa -noout -modulus -in $key | openssl md5)
echo "server> $server_md5"
echo "   key> $key_md5"
if [ $server_md5 = $key_md5 ]; then
  echo -e $'[\e[32mOK\e[m]'
else
  echo -e $'[\e[31mNG\e[m]'
fi
echo "================================"
echo "hash Check."
server_hash=$(openssl x509 -issuer_hash -noout -in $server)
ca_hash=$(openssl x509 -subject_hash -noout -in $ca)
echo "server> $server_hash"
echo "    ca> $ca_hash"
if [ $server_hash = $ca_hash ]; then
  echo -e $'[\e[32mOK\e[m]'
else
  echo -e $'[\e[31mNG\e[m]'
fi
echo "================================"
echo date
openssl x509 -noout -dates -in $server
echo "================================"
echo subject
openssl x509 -in $server -noout -subject