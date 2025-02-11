docker run -d \
  --name=dashy \
  -p 80:80 \
  -v /docker/dashy/conf.yml:/app/public/conf.yml \
  --restart=always \
lissy93/dashy:latest
