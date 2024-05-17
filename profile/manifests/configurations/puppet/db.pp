class profile::configurations::puppet::db (
  $listen_port = hiera('puppet::dashboard::puppetdb::port', 8081)
){
  class { '::profile::applications::puppet::db':
    listen_port => $listen_port,
  }
  # include ::profile::configurations::sensu::checks::host::puppet_db
}
