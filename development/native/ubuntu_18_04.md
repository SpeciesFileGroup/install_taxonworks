TaxonWorks development environment for Ubuntu 18.04
===================================================

Overview
--------
1. Assumes a clean install of the OS.
2. Copy and paste each line, this is not intended to run as a shell script.
3. Carefully read the instructions before each line before exectuting the line.

System Requirements (Recommended)
---------------------------------
1. Memory: 4 GB RAM
2. Storage: 20 GB (when testing with Sandbox data)

Installation Instructions
-------------------------

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
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
```

Install required packages.
```
sudo apt-get install -y postgresql-10 postgresql-contrib-10 libgeos-dev libproj-dev postgresql-10-postgis-2.4 postgresql-10-postgis-2.4-scripts libpq-dev cmake imagemagick libmagickwand-dev git meld curl
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
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y build-essential nodejs
sudo apt-get install npm
```

Install Yarn
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn
```

Install RVM
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

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

When you do `cd taxonworks` you will see a message regarding a particular version of Ruby.  Install that version of Ruby with the command provided in the terminal. It will look something like: `rvm install 2.5.1`.

```
cd ..
cd taxonworks

gem install bundler

bundle
yarn

cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml

rake db:create && bin/rails db:environment:set RAILS_ENV=development

rake db:schema:load && rake db:test:prepare
```

Run the test suite, you may see some failures, but the vast majority should pass.
```
rake 
```

*Corresponding VM is configured to this point.*

If you receive any migration related errors when you run test suite, use the following command before proceeding ahead:
```
rake db:migrate
```
Now proceed ahead to deploy the development server.

Deploy the development server
------------------------------

Compile the Webpack development server use the following command:
```
yarn webpack-dev-server
```

On successful compilation of Webpack development server press CTRL+C, then to start Rails server use following command:
```
rails s
```
Navigate in your browser to 127.0.0.1:3000.  To stop the development server return to the terminal window and type `ctrl-c`. 

Optional
-------- 

If you want to populate the development server with some dummy accounts do this:
```
rake db:seed project_id=123
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

[1]: https://github.com/SpeciesFileGroup/install_taxonworks/blob/master/development/native/tuning_postgres_for_development.md

## Troubleshooting

If you are getting the following message running `rake db:create`:

```
PG::ConnectionBad: FATAL: database "taxonworks_development" does not exist error.
```

You will have to create the database using postgresql console:

```
sudo -u postgres psql
create database mydb;
grant all privileges on database taxonworks_development to taxonworks_development;
```