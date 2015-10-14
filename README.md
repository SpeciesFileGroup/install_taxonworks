tw_provision
============

This repository contains instructions for setup of [development](development/README.md) and [production](production/README.md) environments for [TaxonWorks][1].  It also overviews the software stack.

Software stack
--------------

* Ruby 2.1.n
* Rails 4.2 
* Rubygems
* PostgreSQL with postgis extension
* ImageMagick
* Rtesseract
* Rbenv or [RVM][] (we've used both)
* [Redis][4]

Development tools
-----------------

The core team is using RubyMine and/or VIM, with [brew][3], RVM, JIRA.  They use OS X and Ubuntu 14.04/12.04.

[1]: https://github.com/SpeciesFileGroup/taxonworks
[2]: http://rvm.io
[3]: http://brew.sh/
[4]: http://redis.io/
