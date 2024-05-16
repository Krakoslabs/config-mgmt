#!/bin/bash
sudo su
puppetdir="/etc/puppetlabs/code"

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
yum update -y

writeLog "Installing wget..."
yum install -y wget >/dev/null

writeLog "Configuring PuppetLabs repo..."
yum -y install https://yum.puppetlabs.com/puppet6/puppet6-release-el-7.noarch.rpm

writeLog "Installing Puppet Agent..."
yum install -y puppet-agent-6.0.2

writeLog "Installing Puppet Server..."
yum install -y puppetserver-6.0.1 > /dev/null

writeLog "Installing Git..."
yum install -y git >/dev/null

ruby_version=2.5.1
writeLog "Installing Ruby..."
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 >/dev/null
\curl -sSL https://raw.githubusercontent.com/wayneeseguin/rvm/stable/binscripts/rvm-installer | sudo bash -s stable --ruby=${ruby_version} > /dev/null
source /usr/local/rvm/scripts/rvm

sed -i 's/-Xms2g/-Xms256m/g' /etc/sysconfig/puppetserver
sed -i 's/-Xmx2g/-Xmx256m/g' /etc/sysconfig/puppetserver

writeLog "Puppet Configuration setup"
echo '
[master]
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

echo "alias bu='cd /etc/puppetlabs/code && date && bundle exec librarian-puppet install'" >> /root/.bashrc

cd $puppetdir

writeLog "Installing Bundler..."
gem install bundler -v 1.16.6

source /opt/puppetlabs/bin

writeLog "Setting up the Repository for use..."
bundle install --without development
bundle exec librarian-puppet install
/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
/opt/puppetlabs/bin/puppetserver gem install puppetserver-ca

writeLog "Starting puppetserver service..."
systemctl start puppetserver
