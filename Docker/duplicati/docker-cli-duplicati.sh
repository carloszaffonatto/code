docker run -d \
  --name=duplicati \
  -e PUID=0 \
  -e PGID=0 \
  -e TZ=Europe/London \
  -p 8200:8200 \
  -v /docker/duplicati/config:/config \
  -v /mnt/backups:/backups \
  -v /docker:/source \
  --restart always \
lscr.io/linuxserver/duplicati:latest
