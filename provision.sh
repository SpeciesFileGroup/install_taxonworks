#!/bin/bash

# Target is Unbuntu 14.014

sudo apt-get update

# Build environment
sudo apt-get -y install git gcc nodejs build-essential libffi-dev libgdbm-dev libncurses5-dev libreadline-dev libssl-dev libyaml-dev zlib1g-dev libcurl4-openssl-dev 

# Postgres
sudo apt-get install -y libpq-dev libproj-dev libgeos-dev libgeos++-dev postgis* postgresql

#  ImageMagick
sudo apt-get install -y pkg-config imagemagick libmagickcore-dev libmagickwand-dev 

# Tesseract
sudo apt-get install -y tesseract-ocr

# cmake
sudo apt-get isntall -y cmake

# Rbenv  
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

source ~/.bashrc

CONFIGURE_OPTS="--with-readline-dir=/usr/include/readline" rbenv install 2.1.5 
rbenv global 2.1.5

# Bundler
sudo apt-get -y install bundler

rbenv exec gem install bundler  --no-ri --no-rdoc
rbenv rehash

# apt-get Passenger config
# https://www.phusionpassenger.com/documentation/Users%20guide%20Nginx.html#install_on_debian_ubuntu
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get install apt-transport-https ca-certificates

echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' | sudo tee /etc/apt/sources.list.d/passenger.list  > /dev/null
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 655 /etc/apt/sources.list.d/passenger.list
sudo apt-get update

sudo apt-get install -y nginx-extras passenger


# Manually complete:
# Edit /etc/nginx/nginx.conf and uncomment passenger_root and passenger_ruby. 
# sudo service nginx restart

