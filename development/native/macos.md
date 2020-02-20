# TaxonWorks development environment for MacOS X 

_Last tested March 19 2019_

## Overview

1. Assumes a clean install of the OS.
2. Carefully read the instructions for each line prior to exectuting each line.
3. Copy and paste each line. These instructions are not intended to run as a shell script.
4. TaxonWorks developers generally adopt the convention of creating a `src` directory under their home directory into
 which the taxonworks repository will be cloned.

## Instructions

* Start by getting `Xcode` from the App Store, and install/open it.
* [Install Homebrew](https://brew.sh/)
* [Install RVM](https://rvm.io/rvm/install)
* Install postgis with brew `brew install postgis`, you'll want it to start the service on load, see `brew info postgres` if it doesn't load automatically, it should.
* Install some other packages:
```
brew install imagemagick@6
brew link imagemagick@6 --force
brew install tesseract
brew install node
brew install yarn
```

Install `gnparser` from [here](https://gitlab.com/gogna/gnparser/-/releases).

Close the terminal and open a new one. This will use the new environment created by the previous instructions.

Download the source code from Github:

```
cd src  # or wherever you otherwise elected to put the project source code
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
```

At this point you may see a message regarding a particular version of Ruby. Install that version of Ruby with the commands provided below in the terminal. It will look something like this (for more, e.g. to set as default [see here](https://rvm.io/rubies/default)):
```
rvm install 2.5.1
rvm --default 2.5.1
```
This installs the Ruby version currently being used, and makes it the default.  At this point,
 you can verify this with `rvm list` which will indicate all Ruby versions managed by RVM and their status.


Now it is time to install the required gems and npm dependencies.  Inside the `taxonworks` directory do
```
gem install bundler
bundle
npm install
```

Create a postgres role for taxonworks
```
createuser -s -d -P taxonworks_development (requests password) <- provide alternative for existing user)

cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
```
If you supplied a password in the previous step please edit database.yml accordingly.

### Prepare the database
```
rake db:create
rake db:migrate
rake db:test:prepare
rake db:seed:development project_id=1
```

Install [Firefox](https://www.firefox.com/) browser.

Now `rake` should run tests.

At this point you may use `rake db:seed` to initialize the database for the development environment, or, more typically, you'll load a snapshot of a dumped copy of the data with `rake tw:db:restore file=/path/to/dump.sql`.

### Start the servers

You need to have two servers running:

Webpack (must run in a separate terminal window -- use with caution)
```
./bin/webpack-dev-server
```
Rails 
```
rails server
```

### See the app

Visit http://localhost:3000/ to get started.  You should see the sign-in page.  Since there are no `users` at this point, these must be provisioned.
```apple js
rails console
rake db:seed
```

The username for the dummy account is `user@example.com` and password is `taxonworks`. Note, this account is a regular user and does not have admin privileges. For admin privileges use `admin@example.com` with the password `taxonworks`.

## Troubleshooting

### Webpack out of memory

If you get an error `FATAL ERROR: CALL_AND_RETRY_LAST Allocation failed - JavaScript heap out of memory` increase the memory size for node.
We recommend a npm package to do it automatically.

```
npm install -g increase-memory-limit
increase-memory-limit
```

### Error regarding rmagick

rmagick currently requires a previous version of image magick (see the @6 above).
If you an error regarding rmagick, please run the next two commands and run bundle again:
```
brew uninstall imagemagick
brew install imagemagick@6
export PKG_CONFIG_PATH=/usr/local/Cellar/imagemagick@6/6.9.9-36/lib/pkgconfig
```

To test succesfull install run `identify` in your terminal, if you get the help docs you should be ok.  If brew tells you the package is installed but `identify` does not work try `brew link imagemagick@6 --force`.

## rmagick gem problem
You may have a problem installing the gem `rmagick` having to do with `Package MagickCore was not found in the pkg-config search path.`. If so, execute `find /usr/local -name MagickCore.pc`, and use it in the following line: 

   PKG_CONFIG_PATH='<remove the file name and extension from what you got as a result of the 'find' line and use that>' gem install rmagick

### Proj4 error

This is now a known error for postgis 11.2

If you see an error regarding Proj4 rebuilding it against the latest rgeo-proj4 5.2.0 should resolve the issue, execution order matters! 

See this issue for using 5.2.0 instead of brew's 6.0.0: https://github.com/rgeo/rgeo-proj4/issues/4.  Follow the instructions for the first two lines, you'll need to unlink as well likely (message from first tap command).  Then repeat below.

```
gem uninstall rgeo
gem uninstall rgeo-proj4
gem install rgeo-proj4
bundle install
```
