class profile::applications::sensu::server(
  $password,
  $agent_password,
  $agent_entity_config_password,
  $version,
  $validate_namespaces,
  $api_host,
  $api_port,
  $use_ssl,
  $backends,
  $subscriptions,
  $namespace,
  $sensu_agent_enabled
) {

  # $extra_subscriptions=[downcase($::kernel), downcase($::environment), downcase($::os['architecture'])]
  # $combine_subscriptions = union($subscriptions, $extra_subscriptions)

  class { '::sensu':
    password                     => $password,
    agent_password               => $agent_password,
    agent_entity_config_password => $agent_entity_config_password,
    version                      => $version,
    validate_namespaces          => $validate_namespaces,
    api_host                     => $api_host,
    api_port                     => $api_port,
    use_ssl                      => $use_ssl,
  }
  ## TODO: (2024-06-01): Update sensu::backend class
  include ::sensu::backend

  if $sensu_agent_enabled {

    sensu_namespace { $namespace:
      ensure => 'present',
    }
    class { '::sensu::agent':
      backends        => $backends,
      subscriptions   => ["entity:${trusted['certname']}"],
      namespace       => $namespace,
      entity_name     => $trusted['certname'],
    }
    include ::profile::configurations::sensu::checks::host

  }

}
