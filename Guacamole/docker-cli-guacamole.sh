docker run -d \
  --name guacamole \
  --restart always \
  -p 8080:8080 \
  -e "EXTENSIONS=auth-ldap,auth-duo" \
  -v /docker/guacamole/config:/config \
abesnier/guacamole
