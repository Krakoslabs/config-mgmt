#!/bin/bash
sudo su
puppetdir="/etc/puppetlabs/code"
ruby_version=3.3.1
rbenv_path="/root/.rbenv/bin"
gem_path="/root/.rbenv/versions/${ruby_version}/bin"

writeLog ()
{
    echo "########################################################"
    echo -e "\t\t$1"
    echo "########################################################"
}

if [ "$EUID" -ne "0" ]; then
  writeLog "This script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null 2>&1; then
  writeLog "Puppet is already installed."
  exit 0
fi

writeLog "Updating system..."
apt-get update -y > /dev/null 2>&1

writeLog "Installing wget..."
apt-get install -y wget > /dev/null 2>&1

writeLog "Install some packages..."
apt-get install make gcc zlib1g-dev libffi-dev libtool  libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev -y > /dev/null 2>&1


writeLog "Configuring PuppetLabs repo..."
# yum -y install https://yum.puppetlabs.com/puppet6/el/7/x86_64/puppet6-release-6.0.0-4.el7.noarch.rpm > /dev/null 2>&1
wget https://apt.puppetlabs.com/puppet7-release-focal.deb > /dev/null 2>&1
/usr/bin/dpkg -i puppet7-release-focal.deb > /dev/null 2>&1

writeLog "Updating system..."
apt-get update -y > /dev/null 2>&1

writeLog "Installing Puppet Server..."
apt-get install -y puppetserver > /dev/null 2>&1

writeLog "Installing Git..."
apt-get install -y git >/dev/null

writeLog "Installing rbenv..."
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

writeLog "Installing ruby version: ${ruby_version}"
source ~/.bashrc
${rbenv_path}/rbenv install ${ruby_version}
${rbenv_path}/rbenv global ${ruby_version}

writeLog "Puppet Configuration setup"
sed -i 's/-Xms2g/-Xms256m/g' /etc/default/puppetserver
sed -i 's/-Xmx2g/-Xmx256m/g' /etc/default/puppetserver

echo '
[server]
vardir = /opt/puppetlabs/server/data/puppetserver
logdir = /var/log/puppetlabs/puppetserver
rundir = /var/run/puppetlabs/puppetserver
pidfile = /var/run/puppetlabs/puppetserver/puppetserver.pid
codedir = /etc/puppetlabs/code
environmentpath=$codedir/environments
[agent]
server = puppetserver.vagrant.local
environment = vagrant
pidfile = /var/run/puppetlabs/puppetserver/puppetagent.pid
certname = puppetserver.vagrant.local
' > /etc/puppetlabs/puppet/puppet.conf

echo '*.vagrant.local' > /etc/puppetlabs/puppet/autosign.conf

writeLog "Removing the Default Puppet Folder"
systemctl stop puppetserver
rm -rf $puppetdir

writeLog "Mounting the Puppet Repository"
ln -s /vagrant $puppetdir
sleep 5

echo "alias bu='cd /etc/puppetlabs/code && date && echo "Debug Puppet build: bundle exec librarian-puppet install --verbose" && bundle exec librarian-puppet install'" >> /root/.bashrc
cd $puppetdir

writeLog "Installing Bundler..."
${gem_path}/gem install bundler -v 2.5.10

writeLog "Installing the requirements gems..."
${gem_path}/bundle install

writeLog "Installing the puppet modules..."
${gem_path}/bundle exec ${gem_path}/librarian-puppet install

writeLog "Installing the specific puppetserver gems"
/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
/opt/puppetlabs/bin/puppetserver gem install puppetserver-ca

writeLog "Starting puppetserver service..."
systemctl start puppetserver
