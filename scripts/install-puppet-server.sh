#!/bin/bash

if [ $(which puppet) ]; then
    echo "Puppet present. Skipping installation."
    exit 0
fi

sudo rpm -ivh https://yum.puppetlabs.com/puppet7/puppet-release-el-7.noarch.rpm
sudo yum install epel-release
sudo yum update -y
# I'm sure there more to add here.
sudo yum install nano bash-completion screen -y
sudo yum install puppetserver -y
sudo yum install puppet-bolt -y

sudo hostnamectl set-hostname puppet.lab.test

echo 'dns_alt_names=puppet.lab.test,puppet' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo '' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo '[main]' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo 'certname = puppet.lab.test' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo 'server = puppet.lab.test' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo 'environment = production' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
echo 'runinterval = 1h' | sudo tee -a /etc/puppetlabs/puppet/puppet.conf

sudo systemctl enable puppetserver
sudo systemctl start puppetserver
sudo systemctl status puppetserver
sudo firewall-cmd --add-port=8140/tcp --permanent
sudo firewall-cmd --reload