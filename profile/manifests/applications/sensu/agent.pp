class profile::applications::sensu::agent(
  $backends      = [],
  $subscriptions = [],
  $version       = 'undef',
  $namespace,
  $api_host,
  $api_port,
  $agent_entity_config_password,
  $agent_password
){
  $extra_subscriptions=[downcase($::kernel), downcase($::environment), downcase($::os['architecture'])]
  $combine_subscriptions = union($subscriptions, $extra_subscriptions)

  class { '::sensu':
    api_host                     => $api_host,
    api_port                     => $api_port,
    password                     => $agent_password
  }

  include sensu::cli
  class { '::sensu::agent':
    backends      => $backends,
    subscriptions => $combine_subscriptions,
    version       => $version,
    namespace     => $namespace
  }
}
