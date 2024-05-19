class profile::applications::sensu::server(
  $webui_admin_password,
  $version,
  $agent_entity_config_password
  # $log_level,
  # $client_keepalive = hiera('sensu::client_keepalive', {}),
  # $teams_webhook    = hiera('sensu::teams::webhook', undef),
) {

  class { '::sensu':
    password                     => $webui_admin_password,
    agent_entity_config_password => $agent_entity_config_password,
    version                      => $version
  }
  include ::sensu::backend
  include sensu::cli
  class { '::sensu::agent':
    backends      => ['ubuntu20-2.vagrant.local:8081'],
    subscriptions => [$::environment],
  }
  class { 'sensu::plugins':
    manage_repo => true,
    extensions => ['graphite'],
    dependencies => [],
  }
  # class { 'sensu::plugins':
  #   extensions => ['graphite'],
  # }
  # class { 'sensu::plugins':
  #   plugins => ['disk-checks'],
  #   manage_repo => true
  # }
  # class { '::sensu::plugins':
  #   plugins => {
  #     'disk-checks' => { 'version' => 'latest' },
  #     'memory-checks' => { 'version' => 'latest' },
  #   },
  #   # extensions => ['graphite'],
  # }
  # include ::sensu::api
  # sensu_check { "check-cpu-${facts['fqdn']}":
  #   ensure        => 'absent',
  #   command       => 'check-cpu.sh -w 75 -c 90',
  #   interval      => 60,
  #   subscriptions => ["entity:${facts['fqdn']}"],
  #   provider      => 'sensu_api',
  # }

  #ensure_resource('package', 'ruby-devel', { ensure => present })
  #ensure_resource('Class', '::profile::applications::common::ruby', { })
  #ensure_resource('Class', '::profile::configurations::ssl_certificates::veinternal_wildcard', { })
  # $mutators=hiera('sensu_server::slack::mutators', {})
  # $extra_subscriptions=[downcase($::kernel), downcase($::environment)]
  # $combine_subscriptions=union($subscriptions, $extra_subscriptions)

  # if $teams_webhook != undef {
  #   $teams = {
  #     teams_webhook => $teams_webhook,
  #   }
  # } else {
  #   $teams = { }
  # }

  # $ostype = {
  #   osfamily => $::osfamily,
  # }

  # $client_custom = merge($ostype, $teams)

  # class { '::sensu':
  #   rabbitmq_host                => $rabbitmq_host,
  #   rabbitmq_user                => $rabbitmq_username,
  #   rabbitmq_password            => $rabbitmq_password,
  #   rabbitmq_vhost               => $rabbitmq_vhost,
  #   redis_host                   => $redis_host,
  #   redis_port                   => $redis_port,
  #   redis_password               => $redis_password,
  #   client_address               => $::default_ipaddress,
  #   redis_reconnect_on_error     => true,
  #   transport_reconnect_on_error => true,
  #   server                       => true,
  #   api                          => true,
  #   purge                        => false,
  #   mutators                     => $mutators,
  #   client_custom                => $client_custom,
  #   subscriptions                => $combine_subscriptions,
  #   client_keepalive             => $client_keepalive,
  #   client_bind                  => $::default_ipaddress,
  #   log_level                    => $log_level,
  # }

  #include ::sensu_configuration::mutators::slack_mutated
  #include ::profile::configurations::sensu::checks::host::sensu_server
  #include ::profile::configurations::sensu::metrics::sensu_server

}
