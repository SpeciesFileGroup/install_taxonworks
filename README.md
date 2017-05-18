# Install TaxonWorks

This repository contains instructions for setup of [development](development/README.md) and [production](production/README.md) environments for [TaxonWorks][1]. A  It also overviews the software stack.

# Quick start

If you want to experiment with TaxonWorks before diving deeper it only takes a few steps to get it running:

* Install a virtual machine manager (VirutalBox) 
* Install Docker
* Clone the source code
* `docker-compose up`
* Navigate your browser to `127.0.0.1`:<determine port>

# Next steps

* STUB

## Software stack

* Ruby 2.3.n
* Rails 4.2 
* Rubygems
* PostgreSQL 9.5+ with postgis 2.2 extension
* ImageMagick
* Rtesseract
* Rbenv or [RVM][2] 
* [Redis][4] (experimental use in batch imports)
* vue.js
* jQuery

## Development tools

The core team is using RubyMine and/or VIM, with [brew][3], RVM, JIRA.  They use OS X and Ubuntu 16.04/14.04.

## Production tools

* Docker
* Kubernetes
* Capistrano
* Passenger
* Nginx
* Ubuntu 16.04
* webpack
* Node

[1]: https://github.com/SpeciesFileGroup/taxonworks
[2]: http://rvm.io
[3]: http://brew.sh/
[4]: http://redis.io/
