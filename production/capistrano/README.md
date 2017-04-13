# Deploying and initializing TaxonWorks (Capistrano)

Assumptions/prerequisites
-------------------------

* We are using [Capistrano.](https://github.com/capistrano/capistrano)
* You have two machines, "deploy" and "server", in this example both are Ubuntu 14.04(+) LTS (not 14.10)
* You are resonably capable with a command line environment*
* You have "provisioned" production with the pertinent shell script
* Your "deploy" machine has Ruby, bundler and rubygems installed
* You can ssh without password to your "server"
* Instructions containing all cap values are variables that you must replace (e.g. USERNAME)
* Configure "Server" first, "Deploy" second

On "Server"
-----------

Thanks to [Rob Mclarty's blog post](http://robmclarty.com/blog/how-to-deploy-a-rails-4-app-with-git-and-capistrano) for the general strategy.

Ensure that you can login via ssh with the user that will deploy taxonworks, you can find many places to describe howto set this up.

#### Add a group
```
sudo groupadd deployers
sudo usermod -a -G deployers USERNAME 
```

```
sudo mkdir /var/www
sudo mkdir /var/www/taxonworks
sudo mkdir /var/www/taxonworks/shared
sudo mkdir var/www/taxonworks/shared/config/
sudo chown -R USERNAME:deployers /var/www
sudo chmod -R g+w /var/www
```

####Configure postgres
```
sudo -u postgres psql postgres

alter user postgres with password 'PASSWORD1';
create role taxonworks_production login createdb superuser;
alter user taxonworks_production with password 'PASSWORD2';
```

Configure nginx to point to your passenger ruby, in ```/etc/nginx/nginx.conf``` add/edit the line (change USERNAME!):

```
  passenger_ruby /home/USERNAME/.rbenv/shims/ruby;
```

Set permissions for nginx

```
sudo chmod g+x,o+x /var/www/taxonworks/current/config.ru
sudo chmod g+x,o+x /var/www/taxonworks
sudo chmod g+x,o+x /var/www
sudo chmod g+x,o+x /var/www/taxonworks/current/public
```

Create nginx site

* Add an an available site to /etc/nginx/sites-enabled (see example here)
* Within /etc/nginx/sites-avaiable create a symbolic link

```
sudo ln -ls ../sites-available/taxonworks taxonworks
```


On "Deploy"
-----------

#### Clone the master branch of TaxonWorks.
```
  git clone https://github.com/SpeciesFileGroup/taxonworks.git
```

#### Install capistrano 
```
  gem install capistrano
```

#### Create a new branch, inside your taxonworks folder:
```
  git branch capistrano
```

#### Checkout that branch 
```
  git checkout capistrano
```

#### Run capistrano to setup "capify" taxonworks 
```
 bundle exec cap install
```
This creates a ```config/deploy``` directory, and some sample files.

#### Configure the capistrano files
You can copy the examples from this repository:  
* config/deploy.rb
* config/capistrano/production.rb

Minimally, modify ```production.rb``` to point to your machine, and to use your USERNAME.

#### Copy config files
```
scp config/database.yml USERNAME@SERVERNAME:/var/www/taxonworks/shared/config/database.yml
scp config/application_settings.yml USERNAME@SERVERNAME:/var/www/taxonworks/shared/config/application_settings.yml
```

#### Deploy
Inside your taxonworks directory, with the capistrano branch checkout out
```
cap production deploy
```


