# lint:ignore:node_definition It's the vagrant site file

# To ensure that you don't commit changes on this file by error you can ignore it with:
# git update-index --assume-unchanged environments/vagrant/manifests/site.pp
# If you really need to change it and you ignored it before you can do:
# git update-index --no-assume-unchanged environments/vagrant/manifests/site.pp

# Default Nodes
node default {
  notify { 'This is an unknown node..': }
}

node /centos7-(\d+).vagrant.local/ {
  notify { 'This is a default CentOS 7 node..': }
}

node /ubuntu(\d+).vagrant.local/ {
  notify { 'This is a default Ubuntu 14 node..': }
}

node /win2k12r2-(\d+).vagrant.local/ {
  notify { 'This is a default Windows 2012 R2 node..': }
}

# lint:endignore
