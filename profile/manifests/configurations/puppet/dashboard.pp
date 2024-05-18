class profile::configurations::puppet::dashboard(
  $listen_port,
  $puppet_db_listen_port,
  $puppet_db_server
) { 
  class { '::profile::applications::puppet::dashboard':
    listen_port           => $listen_port,
    puppet_db_listen_port => $puppet_db_listen_port,
    puppet_db_server      => $puppet_db_server
  }
}
