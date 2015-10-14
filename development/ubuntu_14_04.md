# Taxonworks development environment
# Target: Ubuntu 14.04
#
# Assumes a clean install of the OS.
# Copy and paste each line, this is not intended to run as a shell script.
# Carefully read the instructions before each line before exectuting the line.

sudo apt-get update && sudo apt-get dist-upgrade

sudo reboot

sudo apt-get install -y postgresql postgresql-contrib libgeos-dev libproj-dev postgis postgresql-9.3-postgis-2.1 libpq-dev cmake imagemagick libmagickwand-dev git meld

# When prompted do not supply a password. See below, the password must match config/database.yml if provided.
sudo -u postgres createuser -s -d -P taxonworks_development

# Change permissions for posgresql, you are changing 'peer' to 'trust' for the matched line.
sudo sed -i.bak 's/local\s*all\s*all\s*peer/local all all trust/'  /etc/postgresql/9.3/main/pg_hba.conf
sudo service postgresql restart

#  Configure apt-get to point to newer Node packages
curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
sudo apt-get install -y build-essential nodejs

# Install RVM
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# You must now configure your terminal to use RVM.   

# On the terminal menu bar do this:
#    Edit -> Profile preferences -> Title and Command -> *click* 'Run command as login shell'
# !! Close the current terminal open a new one.

mkdir Projects
cd Projects
git clone https://github.com/SpeciesFileGroup/taxonworks.git
cd taxonworks

# You will see a message regarding a particular version of Ruby.  Install that version of Ruby with the command provided in the terminal  It will look something like:
#   rvm install 2.1.5

cd ..
cd taxonworks

gem install bundler

bundle

cp config/database.yml.example config/database.yml

rake db:create && rake db:migrate && rake db:test:prepare 

# Run the test suite, you may see some failures, but the vast majority should pass.
rake 

# You should now be able to start your development server.

rails s

# Navigate in your browser to 127.0.0.1:3000.

# Optional - if you want to populate the development server with some dummy accounts do this:
rake db:seed

# Required for development 

# If you plan on coding and committing back code you'll have had to configure git, at minimum do this
git config --global user.name "Jane Doe"
git config --global user.email person1@example.com
git config --global merge.tool meld


# See also 
* tuning_postgres_for_development.md


