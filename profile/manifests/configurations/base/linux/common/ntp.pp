class profile::configurations::base::linux::common::ntp (
  $servers = hiera('server_config::ntp::servers'),
){
  class { '::ntp':
    servers => $servers,
  }
}
