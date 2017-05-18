# Overview

* `Dockerfile.development` is configured to use with `docker-compose`

# Development quick start

_Assumes you have taxonworks cloned, and docker started. This is an empty (no data) TW instance. See below for restoring/adding data._

* `cd /path/to/taxonworks`
* `git checkout docker`
* `cp config/database.yml.docker.compose config/database.yml`
* `docker-compose build`
* `docker-compose up`
* browse to `127.0.0.1:3000`
* ... do stuff ...
* `docker-compose down`

# Docker notes

* [Docker docs](https://docs.docker.com/)
* `docker ps`
* `docker exec -it taxonworks_app_1 bash`
* `docker stop 3dc4293eg17e`  

## postgres

### Restore a database dumped from `rake tw:db:dump`. 

_Hackish!_

* Ensure the app is not running:
* `docker ps` get id
* `docker stop 3dc4293eg17e` 
* `psql -U postgres -p 15432 -h 0.0.0.0 taxonworks_development` connect directly to the PSQL instance
* Drop and create taxonworks_development, exit: `\c postgres`, `drop database taxonworks_development;`, `create database taxonworks_development;`, `\q` 
* Restore, errors about roles can be ignored.  The process will "fail" but be successful: `pg_restore -U postgres -p 15432 -h 0.0.0.0 -d taxonworks_development /path/to/pg_dump.dump` 

# Development

## Create a user

* Shell into your app (see above)
* `rails c`
*  `User.create!(name: 'you', password: 'password', password_confirmation: 'password', self_created: true, is_administrator: true, email: 'user@example.com')`
* `quit`

## Use a debugger 

Two steps.  Run docker-compose in daemon mode, then attach to the app. Server log/debugger entry point will appear in the window after requests.

* `docker-compose up -d`
* `docker attach taxonworks_app_1` 

## Troubleshooting

### "docker-compose up" fails

* With `A server is already running. Check /app/tmp/pids/server.pid.` If a the app container is not shut down correctly it can leave `tmp/server.pid` in place.  Delete this file on the local system.
* With `(Bundler::GemNotFound)`. Rebuild the containers: `docker-compose build`

### Misc

* Cleanup old containers.  Try `docker images` and `docker rmi <id>` to cleanup old iamges. 
* If you are debugging docker/kubernetes you may need to log to STDOUT, see `config/application.rb`

