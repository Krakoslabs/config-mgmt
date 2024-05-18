class profile::applications::sensu::server(
  $rabbitmq_username,
  $rabbitmq_host,
  $rabbitmq_password,
  $subscriptions,
  $log_level,
  $redis_host       = '127.0.0.1',
  $redis_port       = 6379,
  $redis_password   = undef,
  $client_keepalive = hiera('sensu::client_keepalive', {}),
  $teams_webhook    = hiera('sensu::teams::webhook', undef),
  $rabbitmq_vhost   = hiera('sensu::rabbitmq::vhost'),
) {

  #ensure_resource('package', 'ruby-devel', { ensure => present })
  #ensure_resource('Class', '::profile::applications::common::ruby', { })
  #ensure_resource('Class', '::profile::configurations::ssl_certificates::veinternal_wildcard', { })
  $mutators=hiera('sensu_server::slack::mutators', {})
  $extra_subscriptions=[downcase($::kernel), downcase($::environment)]
  $combine_subscriptions=union($subscriptions, $extra_subscriptions)

  if $teams_webhook != undef {
    $teams = {
      teams_webhook => $teams_webhook,
    }
  } else {
    $teams = { }
  }

  $ostype = {
    osfamily => $::osfamily,
  }

  $client_custom = merge($ostype, $teams)

  class { '::sensu':
    rabbitmq_host                => $rabbitmq_host,
    rabbitmq_user                => $rabbitmq_username,
    rabbitmq_password            => $rabbitmq_password,
    rabbitmq_vhost               => $rabbitmq_vhost,
    redis_host                   => $redis_host,
    redis_port                   => $redis_port,
    redis_password               => $redis_password,
    client_address               => $::default_ipaddress,
    redis_reconnect_on_error     => true,
    transport_reconnect_on_error => true,
    server                       => true,
    api                          => true,
    purge                        => false,
    mutators                     => $mutators,
    client_custom                => $client_custom,
    subscriptions                => $combine_subscriptions,
    client_keepalive             => $client_keepalive,
    client_bind                  => $::default_ipaddress,
    log_level                    => $log_level,
  }

  #include ::sensu_configuration::mutators::slack_mutated
  #include ::profile::configurations::sensu::checks::host::sensu_server
  #include ::profile::configurations::sensu::metrics::sensu_server

}
