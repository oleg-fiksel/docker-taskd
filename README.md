# Taskwarrior

## Config

Details: https://gitpitch.com/GothenburgBitFactory/taskserver-setup#/

```
...
log=/log/taskd.log
pid.file=/data/taskd.pid
root=/data
server=taskd:53589
client.cert=/data/certs/client.cert.pem
client.key=/data/certs/client.key.pem
server.cert=/data/certs/server.cert.pem
server.key=/data/certs/server.key.pem
server.crl=/data/certs/server.crl.pem
ca.cert=/data/certs/ca.cert.pem
...
```

## Running

### docker-compose

TODO

## docker swarm

Docker stack file:
```
version: '3.2'
services:
 taskd:
  image: "olegfiksel/docker-taskd"
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

## docker commandline

`docker run --rm -ti -v /path/to/data:/data -h taskd -p 53589:53589 olegfiksel/docker-taskd`
