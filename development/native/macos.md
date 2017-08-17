# TaxonWorks development environment for MacOS X 

## Overview

1. Assumes a clean install of the OS.
2. Carefully read the instructions for each line prior to exectuting each line.
3. Copy and paste each line. These instructions are not intended to run as a shell script.

## Instructions
Start by opening a terminal window. The following instructions should be executed within it.

Install Homebrew, the MAC OS application consturction utility.

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
If/when prompted, click on install button. Follow through with the Homebrew install process. 

After Homebrew, install RVM, the Ruby version manager. This consists of installing the GNU Privacy Guard (gnupg), getting the public key for RVM, and installing RVM. The particular invocation below also installes the latest stable version of Ruby.

```
brew install gnupg
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

Next, you should install a few brew packages.
```
brew install postgres
brew install postgis 
brew install imagemagick
brew install cmake
brew install node
brew install yarn
```

Set up PostgreSQL to start automatically. First, find or create your local LaunchAgents directory. Next, make a link to be executed when you log on. Last, launch the PostgreSql server for the first time. You will need the server running for some of the following instructions.
```
mkdir -p ~/Library/LaunchAgents    # This may already exist.   
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```
Close the terminal and open a new one. This will use the new environment created by the previous instructions.

Get TaxonWorks source code into the computer.
```
mkdir Projects # This directory can be named whatever you please...
cd Projects
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
```
At this point you may see a message regarding a particular version of Ruby. Install that version of Ruby with the command provided in the terminal. It will look something like this:
```
rvm install 2.4.1
```

Now it is time to install the required gems and npm dependencies
```
cd ..
cd taxonworks
gem install bundle
bundle
yarn
```

If you an error regarding rmagick, please run the next two commands and run bundle again:
```
brew uninstall imagemagick
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/6f014f2b7f1f9e618fd5c0ae9c93befea671f8be/Formula/imagemagick.rb
```

Create a postgres role for taxonworks
```
createuser -s -d -P taxonworks_development
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
```
If you supplied a password in the previous step please edit database.yml accordingly.

```
rake db:create
```
If you see an error regarding Proj4 please run the next two commands and repeat previous step.
```
gem uninstall rgeo
gem install rgeo
```

### Prepare the database
```
rake db:create
rake db:migrate
rake db:test:prepare
```

Install [Firefox](https://www.firefox.com/) browser.

Now `rake` should run tests.

You may use `rake db:seed` to initialize the database for the development environment

### Start the servers

You need to have two servers running:

Rails 
```
rails server
```
Webpack
```
./bin/webpack-dev-server
```

### See the app

Visit http://localhost:3000/ to get started.

The username for the dummy account is user@example.com and password is taxonworks. Note, this account is a regular user and does not have admin privileges. For admin privileges use admin@example.com (same password).
