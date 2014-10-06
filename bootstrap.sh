#!/usr/bin/env bash

apt-get update
apt-get -y dist-upgrade

apt-get install -y git
apt-get install -y build-essential
apt-get install -y subversion
apt-get install -y mono-complete
apt-get install -y libmonosgen-2.0-dev
apt-get install -y ruby-dev
gem install fpm
