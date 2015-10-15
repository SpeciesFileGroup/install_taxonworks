TaxonWorks development environment for MacOS X 
==============================================
Overview
--------
1. Assumes a clean install of the OS.
2. Copy and paste each line, this is not intended to run as a shell script.
3. Carefully read the instructions before each line before exectuting the line.

Instructions
------------

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
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
```
At this point you may see a message regarding a particular version of Ruby. Install that version of Ruby with the command provided in the terminal. It will look something like this:
```
rvm install 2.1.5
```

Now it is time to install the required gems
```
cd ..
bundle
cd taxonworks
```

Create a role for taxonworks
```
createuser -s -d -P taxonworks_development
cp config/database.yml.example config/database.yml
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

Prepare the database
```
rake db:create
rake db:migrate
rake db:test:prepare
```

Install [Firefox](https://www.firefox.com/) browser.

Now `rake` should run tests.

You may use `rake db:seed` to initialize the database for the development environment, start the server with `rails server` and visit http://localhost:3000/ to get started. Supply `person1@example.com` for user and `Abcd123!` for password.
