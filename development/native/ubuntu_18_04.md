TaxonWorks development environment for Ubuntu 18.04
===================================================

Overview
--------
1. Assumes a clean install of the OS.
2. Copy and paste each line, this is not intended to run as a shell script.
3. Carefully read the instructions before each line before exectuting the line.

System Requirements (Recommended)
---------------------------------
1. Memory: 8 GB RAM
2. Storage: 32 GB (when testing with Sandbox data)

Installation Instructions
-------------------------

Open a terminal.
```
sudo apt update && sudo apt dist-upgrade
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
sudo apt-get install -y postgresql-12 postgresql-contrib-12 libgeos-dev postgresql-12-postgis-3 postgresql-12-postgis-3-scripts libpq-dev cmake imagemagick libmagickwand-dev tesseract-ocr git meld curl libsqlite3-dev
```

Ubuntu 18.04 does not have up to date packages for libproj-dev, so it has toe be built from source
```
wget https://download.osgeo.org/proj/proj-6.3.1.tar.gz -O- | tar -xzf-
cd proj-6.3.1
./configure
make
sudo make install
cd ..
rm -rf proj-6.3.1
```

When prompted do not supply a password. See below, the password must match `config/database.yml` if provided.
```
sudo -u postgres createuser -s -d -P taxonworks_development
```

Change permissions for posgresql, you are changing 'peer' to 'trust' for the matched line.
```
sudo sed -i.bak 's/local\s*all\s*all\s*peer/local all all trust/'  /etc/postgresql/12/main/pg_hba.conf
sudo service postgresql restart
```

Configure apt-get to point to newer Node packages
```
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y build-essential nodejs
```

Install RVM
```
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

Configure your terminal to use RVM, in the menu bar of the terminal do this: Edit -> Preferences -> Command -> click the option (turn on) 'Run command as login shell'

Close the current terminal open a new one.

```
mkdir Projects
cd Projects
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks
```

When you do `cd taxonworks` you will see a message regarding a particular version of Ruby.  Install that version of Ruby with the command provided in the terminal. It will look something like: `rvm install 3.0.2`.

```
cd . # Refreshes rvm to pick up recently installed ruby above
gem install bundler

bundle
npm install

cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml

bundle exec rake db:create && bundle exec bin/rails db:environment:set RAILS_ENV=development

bundle exec rake db:schema:load && bundle exec rake db:test:prepare
```

Run the test suite, you may see some failures, but the vast majority should pass.
```
bundle exec rake
```

If you receive any migration related errors when you run test suite, use the following command before proceeding ahead:
```
bundle exec rake db:migrate
```
Now proceed ahead to deploy the development server.

Deploy the development server
------------------------------

Before starting rails server it is recommended -but not strictly required- to start the Webpack development server first on a separate terminal so assets are rebuilt faster when developing:
```
npm run webpack-dev-server
```
Alternatively you may run `bundle exec rails assets:precompile` (but any change you make will take longer to materialize when browsing).

Start the web server with the following command: *(If you followed the recommendation above then wait for assets compilation to finish before proceeding)*
```
bundle exec rails s
```
Navigate in your browser to 127.0.0.1:3000.  To stop the development server return to the terminal window and type `ctrl-c`.

Optional
-------- 

If you want to populate the development server with some dummy accounts do this:
```
bundle exec rake db:seed
```
The username for the dummy account is `user@example.com` and password is `taxonworks`. Note, this account is a regular user and does not have admin privileges. For admin privileges use `admin@example.com` (same password).

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

If you are getting the following message running `bundle exec rake db:create`:

```
PG::ConnectionBad: FATAL: database "taxonworks_development" does not exist error.
```

You will have to create the database using postgresql console:

```
sudo -u postgres psql
create database taxonworks_development;
grant all privileges on database taxonworks_development to taxonworks_development;
```
