class profile::configurations::sensu::agent (
  $backends                     = hiera('sensu::server::backends', []),
  $subscriptions                = hiera('sensu::agent::subscriptions', []),
  $version                      = hiera('sensu::agent::version', 'installed'),
  $namespace                    = hiera('sensu::agent::namespace'),
  $api_host                     = hiera('sensu::server::api_host'),
  $api_port                     = hiera('sensu::server::api_port'),
  $agent_entity_config_password = hiera('sensu::agent::agent_entity_config_password'),
  $agent_password               = hiera('sensu::agent::agent_password'),
){

  class { '::profile::applications::sensu::agent':
    backends                     => $backends,
    subscriptions                => $subscriptions,
    version                      => $version,
    namespace                    => $namespace,
    api_host                     => $api_host,
    api_port                     => $api_port,
    agent_entity_config_password => $agent_entity_config_password,
    agent_password               => $agent_password
  }

  # include ::profile::configurations::sensu::checks::host

  # if $enable_metrics {
  #   include ::profile::configurations::sensu::checks::metrics
  # }
}
