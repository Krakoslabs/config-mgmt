#!/bin/bash
sudo su
puppetagentdir="/etc/puppetlabs/puppet"
. /etc/os-release

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


function install_centos (){
  writeLog "Updating centos machine...."
  #yum -y update
  writeLog "Installing wget..."
  yum install -y wget >/dev/null

  writeLog "Configuring PuppetLabs repo..."
  yum -y install https://yum.puppetlabs.com/puppet6/el/7/x86_64/puppet6-release-6.0.0-4.el7.noarch.rpm > /dev/null

  writeLog "Installing Puppet Agent..."
  yum install -y puppet-agent-6.0.2 > /dev/null
}

# Check me if I work
function install_ubuntu (){
  writeLog "Installing wget..."
  apt-get install -y wget > /dev/null 2>&1

  writeLog "Configuring PuppetLabs repo..."
  version=$VERSION_CODENAME
  REPO_URL="https://apt.puppetlabs.com/puppet7-release-focal.deb"
  wget $REPO_URL > /dev/null 2>&1
  /usr/bin/dpkg -i puppet7-release-focal.deb > /dev/null 2>&1


  writeLog "Installing Puppet Agent..."
  apt-get update > /dev/null 2>&1
  apt-get install -y puppet-agent > /dev/null 2>&1
}

if [ $(echo $NAME | grep -ci "ubuntu") == 1 ]; then
  install_ubuntu
else
  install_centos
fi

writeLog "Setting the Puppet Configuration.."
echo "
[main]
server             = puppetserver.vagrant.local
environment        = vagrant
report             = true
splay              = false
usecacheonfailure  = false
ssldir             = $puppetagentdir/ssl
rundir             = /var/run/puppet
" > $puppetagentdir/puppet.conf
