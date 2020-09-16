# Backup

Backup is a simple lightweight tool to backup your databases.\
It parse any of your running container to find databases, connects to each one of them and execute a simple backup using native provided tools.\
Supported databases :
- MySQL
- MongoDB
- PostgreSQL

It keeps :
- The first backup of each month
- The last 14 backups

To backup multiple databases, please provide `db.backup.multiple` label to the database container.

## Supported tags

* `latest`, `1.0` ([Dockerfile](https://github.com/xylphid/docker-db-backup-n-sync/blob/master/Dockerfile)))

## How to use this image

### Environments

Here are supported environments variable and its definition :
- `CRONFIG` : Crontab scheduling (_default : "0 23 * * *"_)

### Running the container

```bash
$ docker run -d --name backup \
    -v //var/run/docker.sock:/var/run//docker.sock \
    -v /path/to/backups:/opt/backups
    xylphid/db-backup-n-sync:latest
```

### How to compose with this image

```yml
version: "3"

services:
  cron:
    environment:
      CRONFIG: "0 23 * * *"
    image: xylphid/db-backup-n-sync:latest
    volumes:
      - //var/run/docker.sock:/var/run/docker.sock
      - backup-volume:/opt/backups/
      - backup-nas-volume:/opt/backups-dist/
```

### Swarm reflexion

On swarm, you may use this image on global mode.
```yml
version: "3"

services:
  cron:
    deploy:
      mode: global
      restart_policy:
        condition: on-failure
      update_config:
        delay: 20s
        failure_action: rollback
        monitor: 30s
        order: start-first
    environment:
      CRONFIG: "0 23 * * *"
    image: xylphid/db-backup-n-sync:latest
    volumes:
      - //var/run/docker.sock:/var/run/docker.sock
      - backup-volume:/opt/backups/
```

## Image inheritance

This docker image inherits from [docker](https://hub.docker.com/_/docker/) image.
