# TaxonWorks development environment for MacOS X 

## Overview

1. Assumes a clean install of the OS.
2. Copy and paste each line, this is not intended to run as a shell script.
3. Carefully read the instructions before each line before exectuting the line.

## Instructions

Open a terminal.

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
When or if prompted click on install button.

Follow through Homebrew install process. When done, you can proceed to install RVM.

```
brew install gnupg
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

You now should install a few brew packages.
```
brew install postgres
brew install postgis 
brew install imagemagick
brew install cmake
brew install node
brew install yarn
```

Set up PostgreSQL to start automatically.
```
mkdir -p ~/Library/LaunchAgents    # This may already exist.   
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```
Close the terminal and open a new one.

Get TaxonWorks source code into the computer.
```
mkdir Projects
cd Projects
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
```
At this point you may see a message regarding a particular version of Ruby. Install that version of Ruby with the command provided in the terminal. It will look something like this:
```
rvm install 2.3.3
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
$ brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/6f014f2b7f1f9e618fd5c0ae9c93befea671f8be/Formula/imagemagick.rb
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
