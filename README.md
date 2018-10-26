# Taskwarrior

## Config

Details:
* https://taskwarrior.org/docs/taskserver/setup.html
* https://gitpitch.com/GothenburgBitFactory/taskserver-setup#/

/data/config:
```
...
log=/log/taskd.log
pid.file=/data/taskd.pid
root=/data
server=0.0.0.0:53589
client.cert=/data/certs/client.cert.pem
client.key=/data/certs/client.key.pem
server.cert=/data/certs/server.cert.pem
server.key=/data/certs/server.key.pem
server.crl=/data/certs/server.crl.pem
ca.cert=/data/certs/ca.cert.pem
...
```

## Running

### docker-compose/swarm

Docker stack file:
```
version: '3.2'
services:
 taskd:
  image: "olegfiksel/docker-taskd"
#  healthcheck:
#    test: ["CMD", "nc", "-q1", "taskd", "53589", "</dev/null"]
#    interval: 1m
#    timeout: 10s
#    retries: 3
#    start_period: 30s
  environment:
    TZ: Europe/Berlin
  ports:
    - "53589:53589"
  volumes:
   - "data:/data:nocopy"
   - "log:/log:nocopy"
volumes:
  data:
  log:
```

### docker commandline

`docker run --rm -ti -v /path/to/data:/data -p 53589:53589 olegfiksel/docker-taskd`
