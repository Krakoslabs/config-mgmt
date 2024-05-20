class profile::applications::sensu::server(
  $password,
  $agent_password,
  $version,
  $agent_entity_config_password,
  $backends,
  $subscriptions,
  $validate_namespaces,
  $namespace,
  $api_host,
  $api_port,
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
    api_port                     => $api_port
  }
  # TODO: Update sensu::backend class
  include ::sensu::backend

  if $sensu_agent_enabled {
    include sensu::cli

    class { '::sensu::agent':
      backends        => $backends,
      subscriptions   => $extra_subscriptions,
      namespace       => $namespace,
      entity_name     => $::certname
    }
  }

}
