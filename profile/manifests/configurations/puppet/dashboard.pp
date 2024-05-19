class profile::configurations::puppet::dashboard(
  $listen_port           = hiera('puppet::dashboard::listen_port', 'ubuntu20-1.vagrant.local'),
  $puppet_db_listen_port = hiera('puppet::dashboard::puppetdb::puppet_db_listen_port', 'ubuntu20-1.vagrant.local'),
  $puppet_db_server      = hiera('puppet::dashboard::puppetdb::puppet_db_server', 'ubuntu20-1.vagrant.local'),
) { 
  class { '::profile::applications::puppet::dashboard':
    listen_port           => $listen_port,
    puppet_db_listen_port => $puppet_db_listen_port,
    puppet_db_server      => $puppet_db_server
  }
}
