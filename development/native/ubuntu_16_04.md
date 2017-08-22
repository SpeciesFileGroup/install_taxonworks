TaxonWorks development environment for Ubuntu 16.04
===================================================

Overview
--------
1. Assumes a clean install of the OS.
2. Copy and paste each line, this is not intended to run as a shell script.
3. Carefully read the instructions before each line before exectuting the line.

Instructions
------------

Open a terminal.
```
sudo apt-get update && sudo apt-get dist-upgrade
```

Reboot the machine
```
sudo reboot
```  

Reopen a terminal.

Add PostgreSQL source repository for apt-get.
```
echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
```

Install required packages.
```
sudo apt-get install -y postgresql-9.5 postgresql-contrib-9.5 libgeos-dev libproj-dev postgresql-9.5-postgis-2.2 postgresql-9.5-postgis-2.2-scripts libpq-dev cmake imagemagick libmagickwand-dev git meld
```

When prompted do not supply a password. See below, the password must match config/database.yml if provided.
```
sudo -u postgres createuser -s -d -P taxonworks_development
```

Change permissions for posgresql, you are changing 'peer' to 'trust' for the matched line.
```
sudo sed -i.bak 's/local\s*all\s*all\s*peer/local all all trust/'  /etc/postgresql/9.5/main/pg_hba.conf
sudo service postgresql restart
```

Configure apt-get to point to newer Node packages
```
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y build-essential nodejs
```

Install Yarn
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn
```

Install RVM
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

Configure your terminal to use RVM, in the menu bar of the terminal do this:
`Edit -> Profile preferences -> Command -> click the option (turn on) 'Run command as login shell'`

Close the current terminal open a new one.

```
mkdir Projects
cd Projects
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
```

When you do `cd taxonworks` you will see a message regarding a particular version of Ruby.  Install that version of Ruby with the command provided in the terminal  It will look something like: `rvm install 2.4.1`.

```
cd ..
cd taxonworks

gem install bundler

bundle
yarn

cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml

rake db:create && rake db:schema:load && rake db:test:prepare
```

In order to make feature tests work, currently you need either Google Chrome or Firefox not newer than version 47.0.1. Ubuntu comes with a much newer Firefox so we need to install a browser. Since Travis CI uses Firefox when testing the repo, we'll proceed to install it and configure TaxonWorks to use our downloaded version rather than the Ubuntu-provided one:
```
wget -O - "https://download.mozilla.org/?product=firefox-47.0.1&lang=en-US&os=linux64" | tar -jx -C ~
sudo mv ~/firefox /opt/firefox-47.0.1
cat > config/application_settings.yml <<EOF
test:
  selenium:
    browser: 'firefox'
    firefox_binary_path: '/opt/firefox-47.0.1/firefox'
EOF
```

Run the test suite, you may see some failures, but the vast majority should pass.
```
rake 
```

*Corresponding VM is configured to this point.*

You should now be able to start your development server.

```
./bin/webpack-dev-server
rails s
```

Navigate in your browser to 127.0.0.1:3000.  To stop the development server return to the terminal window and type `ctrl-c`. 

Optional
-------- 

If you want to populate the development server with some dummy accounts do this:
```
rake db:seed
```
The username for the dummy account is `user@example.com` and password is `taxonworks`. Note, this account is a regular user and does not have admin privileges. For admin privileges use admin@example.com (same password).

Required for development 
------------------------

If you plan on coding and committing back code you'll have had to configure git, at minimum do this
```
git config --global user.name "Jane Doe"
git config --global user.email developer@example.com
git config --global merge.tool meld
```

See also 
--------

* [tuning_postgres_for_development.md][1]
 
[1]: https://github.com/SpeciesFileGroup/tw_provision/blob/master/development/tuning_postgres_for_development.md
