docker run -d \
  --name=komga \
  --user 1000:1000 \
  -p 25600:25600 \
  --mount type=bind,source=/path/to/config,target=/config \
  --mount type=bind,source=/path/to/data,target=/data \
  --restart unless-stopped \
  gotson/komga
