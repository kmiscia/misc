#!/bin/sh
# Modified by myself, but original courtesy of https://github.com/brookemckim

rubies=$1

ruby_www="http://ftp.ruby-lang.org/pub/ruby"
ruby_install_dir="/usr/local/ruby-$rubies"

if [ -z $1 ]; then
  rubies='1.9.3-p0'
  echo "Installing $rubies"
else
  rubies=$1
  echo "Installing $1"
fi  

if [[ "$rubies" == 1.9* ]]; then
  ver="1.9"
elif [[ "$rubies" == 1.8* ]]; then
  ver="1.8"
else
  echo "Unrecognized Ruby version"
  exit 1
fi      

apt-get update -y

apt-get install -y git-core
apt-get install -y subversion
apt-get install -y vim
apt-get install -y zlib1g-dev
apt-get install -y libssl-dev
apt-get install -y libruby1.8
apt-get install -y libxslt-dev
apt-get install -y libxml2-dev
apt-get install -y libreadline5-dev
apt-get install -y libncurses5-dev
apt-get install -y libreadline5
apt-get install -y libyaml-dev

wget $ruby_www/$ver/ruby-$rubies.tar.gz -O - | tar xzv \

mkdir -p $ruby_install_dir
cd $ruby_install_dir

./configure
make
make install

gem update --system
gem install bundler --no-ri --no-rdoc