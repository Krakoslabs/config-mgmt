class profile::configurations::puppet::db (
  $listen_port,
  $ssl_listen_port
){
  class { '::profile::applications::puppet::db':
    listen_port     => $listen_port,
    ssl_listen_port => $ssl_listen_port
  }
  # include ::profile::configurations::sensu::checks::host::puppet_db
}
