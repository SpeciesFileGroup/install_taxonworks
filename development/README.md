
# Quickstart

* Install [Docker](https://www.docker.com/get-docker)
* Install a virtual machine manager (e.g. [Virtual Box](https://www.virtualbox.org/wiki/Downloads))
* `git clone git@github.com:SpeciesFileGroup/taxonworks.git`
* `cd taxonworks`
* `cp config/database.yml.docker.compose config/database.yml` 
*  Browse to `127.0.0.1:3000`

Take the [next steps here](docker/README.md).

# Development environments

* You want to maximize performance, and are OK with getting your hands dirty: Use a [native environment](native/README.md)
* You want to write code against the API, or make smaller changes: Use [Docker](docker/README.md)
* You want to use an Ubuntu virtual machine, with everything configured: Use a [virtual machine](vm/README.md) (more or less deprecated for the Docker approach, but still maintained)
