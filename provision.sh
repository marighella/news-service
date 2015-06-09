#!/bin/bash

function install_git {
	sudo apt-get -y install git
}

function install_rbenv {
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	echo 'export PATH="/home/vagrant/.rbenv/bin:$PATH"' >> ~/.bash_profile
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	source ~/.bash_profile
}

function install_ruby {
    sudo apt-get -y install zlib1g zlib1g-dev openssl libssl-dev
	rbenv install 2.2.2
    rbenv rehash
    pushd /vagrant
	    gem install bundler
    popd
}

function install_dependencies {
    pushd /vagrant
        bundle install
    popd
}

sudo apt-get update

install_git
install_rbenv
install_ruby
install_dependencies
