#!/bin/bash
sudo su
puppetdir="/etc/puppetlabs/code"
ruby_version=2.5.1
rbenv_path="/root/.rbenv"
gem_path="/root/.rbenv/versions/2.5.1/bin"

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
yum update -y >/dev/null

writeLog "Installing wget..."
yum install -y wget >/dev/null

writeLog "Install some packages..."
yum install -y gcc openssl-devel readline-devel zlib-devel > /dev/null

writeLog "Configuring PuppetLabs repo..."
yum -y install https://yum.puppetlabs.com/puppet6/el/7/x86_64/puppet6-release-6.0.0-4.el7.noarch.rpm > /dev/null

writeLog "Installing Puppet Agent..."
yum install -y puppet-agent-6.0.2 > /dev/null

writeLog "Installing Puppet Server..."
yum install -y puppetserver-6.0.1 > /dev/null

writeLog "Installing Git..."
yum install -y git >/dev/null

writeLog "Installing rbenv..."
git clone git://github.com/sstephenson/rbenv.git $rbenv_path
git clone git://github.com/sstephenson/ruby-build.git $rbenv_path/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /root/.bash_profile
echo 'eval "$(rbenv init -)"' >> /root/.bash_profile

$rbenv_path/bin/rbenv install -v $ruby_version > /dev/null
$rbenv_path/bin/rbenv global $ruby_version > /dev/null

source ~/.bash_profile

writeLog "Puppet Configuration setup"
sed -i 's/-Xms2g/-Xms256m/g' /etc/sysconfig/puppetserver
sed -i 's/-Xmx2g/-Xmx256m/g' /etc/sysconfig/puppetserver

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
$gem_path/gem install bundler -v 1.16.6

writeLog "Installing the requirements gems..."
$gem_path/bundle install --without development

writeLog "Installing the puppet modules..."
$gem_path/bundle exec $gem_path/librarian-puppet install

writeLog "Installing the specific puppetserver gems"
/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
/opt/puppetlabs/bin/puppetserver gem install puppetserver-ca

writeLog "Starting puppetserver service..."
systemctl start puppetserver
