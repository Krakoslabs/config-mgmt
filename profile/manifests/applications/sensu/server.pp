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

  $extra_subscriptions=[downcase($::kernel), downcase($::environment), downcase($::os['architecture'])]
  $combine_subscriptions = union($subscriptions, $extra_subscriptions)

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
  # TODO: Update sensu::backend class
  include ::sensu::backend

  if $sensu_agent_enabled {

    class { '::sensu::agent':
      backends        => $backends,
      subscriptions   => $extra_subscriptions,
      namespace       => $namespace,
      entity_name     => $::certname,
    }
    include ::profile::configurations::sensu::checks::host

  }

}
