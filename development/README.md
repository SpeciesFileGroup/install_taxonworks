
# Quickstart

* Install [Docker](https://www.docker.com/get-docker)
* Clone the source code `git clone https://github.com/SpeciesFileGroup/taxonworks.git`
* Follow the [instructions for using docker](docker/README.md).

# Development environments

* You want to maximize performance, and are OK with getting your hands dirty: Use a [native environment](native/README.md)
* You want to write code against the API, or make smaller changes: Use [Docker](docker/README.md)
* You want to use an Ubuntu virtual machine, with everything configured: Use a [virtual machine](vm/README.md) (more or less deprecated for the Docker approach, but still maintained)

# Day to day use

The codebase changes relatively rapidly.  There are some general patterns that you can follow to ensure syncing and keeping your development environment up to date does not give you a headache.

## Every day, before you start to code:

_assumes you're in the TaxonWorks path_

* `git pull` get the latest code
* run a test or two to see that your environment is not borked `spring rspec spec/models/otu_spec.rb`

You might also:

* `bundle install` to update your gem libraries
* `rake db:migrate` to see if there are database migrations

## On OS X system updates

* review your Ruby configuration
* agree to the new XCode terms of service

## On Ruby version bumps

* check that you're running the required Ruby `which ruby`
* reinstall Ruby as per instructions
* reinstall your ruby gems
