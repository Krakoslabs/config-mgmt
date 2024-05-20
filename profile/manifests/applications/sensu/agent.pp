class profile::applications::sensu::agent(
  $backends      = [],
  $subscriptions = [],
  $version       = 'undef',
  $namespace,
  $api_host,
  $api_port,
  $agent_entity_config_password,
  $agent_password,
  $validate_namespaces,
  $validate_api,
  $validate_entity
){
  $extra_subscriptions = [downcase($::kernel), downcase($::environment), downcase($::os['architecture'])]
  $combine_subscriptions = union($subscriptions, $extra_subscriptions)

  class { '::sensu':
    api_host                     => $api_host,
    api_port                     => $api_port,
    password                     => $agent_password,
    agent_password               => $agent_password,
    validate_namespaces          => Boolean($validate_namespaces),
    validate_api                 => $validate_api,
  }

  include sensu::cli
  class { '::sensu::agent':
    backends        => $backends,
    subscriptions   => $combine_subscriptions,
    version         => $version,
    namespace       => $namespace,
    validate_entity => $validate_entity,
    entity_name     => $::certname
  }
}
