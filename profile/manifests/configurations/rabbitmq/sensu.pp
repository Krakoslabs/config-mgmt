class profile::configurations::rabbitmq::sensu
{
  $username        = hiera('sensu::rabbitmq::username')
  $password        = hiera('sensu::rabbitmq::password')
  $cluster_enabled = hiera('sensu::rabbitmq::cluster_enabled', undef)
  $cluster_nodes   = hiera('sensu::rabbitmq::cluster_nodes', [])
  $erlang_version  = hiera('sensu::rabbitmq::erlang_version', undef)
  $erlang_cookie   = hiera('sensu::rabbitmq::erlang_cookie', undef)
  $home_dir        = hiera('sensu::rabbitmq::home_dir', '/var/lib/rabbitmq')
  $vhost           = hiera('sensu::rabbitmq::vhost')
  $management_ssl  = false

  class { '::profile::applications::common::rabbitmq':
    user                       => {
      name     => $username,
      password => $password,
      admin    => true,
    },
    vhost                      => $vhost,
    cluster_enabled            => $cluster_enabled,
    cluster_nodes              => $cluster_nodes,
    erlang_cookie              => $erlang_cookie,
    home_dir                   => $home_dir,
    cluster_partition_handling => 'autoheal',
    erlang_version             => $erlang_version,
    management_ssl             => $management_ssl,
  }

  # include ::profile::configurations::sensu::checks::host::rabbitmq
  # include ::profile::configurations::consul::services::infrastructure::rabbitmq

}
