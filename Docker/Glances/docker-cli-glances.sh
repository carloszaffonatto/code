docker run -d \
  --name=glances \
  --restart="always" \
  -p 61208-61209:61208-61209 \
  -e GLANCES_OPT="-w" \
  -v /docker/glances/glances.conf:/glances/conf/glances.conf \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  --pid host \
nicolargo/glances:latest
