class profile::configurations::puppet::db (
  $listen_port     = hiera('puppet::dashboard::puppetdb::port', 'ubuntu20-1.vagrant.local'),
  $ssl_listen_port = hiera('puppet::dashboard::puppetdb::ssl_port', 'puppetserver.vagrant.local'),
){
  class { '::profile::applications::puppet::db':
    listen_port     => $listen_port,
    ssl_listen_port => $ssl_listen_port
  }
  # include ::profile::configurations::sensu::checks::host::puppet_db
}
