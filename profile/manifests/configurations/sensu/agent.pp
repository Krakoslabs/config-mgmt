class profile::configurations::sensu::agent (
  $backends                     = hiera('sensu::server::backends', []),
  $subscriptions                = hiera('sensu::agent::subscriptions', []),
  $version                      = hiera('sensu::agent::version', 'installed'),
  $namespace                    = hiera('sensu::agent::namespace'),
  $api_host                     = hiera('sensu::server::api_host'),
  $api_port                     = hiera('sensu::server::api_port'),
  $use_ssl                      = hiera('sensu::agent::use_ssl', false),
  $password                     = hiera('sensu::agent::password', undef),
  $agent_password               = hiera('sensu::agent::agent_password', undef),
  $agent_entity_config_password = hiera('sensu::agent::agent_entity_config_password', undef),
  $validate_namespaces          = hiera('sensu::agent::validate_namespaces'),
  $validate_api                 = hiera('sensu::agent::validate_api'),
  $validate_entity              = hiera('sensu::agent::validate_entity'),
  $enable_metrics               = hiera('sensu::metrics::enable', false)
){

  class { '::profile::applications::sensu::agent':
    backends                     => $backends,
    subscriptions                => $subscriptions,
    version                      => $version,
    namespace                    => $namespace,
    api_host                     => $api_host,
    api_port                     => $api_port,
    use_ssl                      => Boolean($use_ssl),
    password                     => $password,
    agent_password               => $agent_password,
    agent_entity_config_password => $agent_entity_config_password,
    validate_namespaces          => $validate_namespaces,
    validate_api                 => $validate_api,
    validate_entity              => $validate_entity
  }

  include ::profile::configurations::sensu::checks::host

  if $enable_metrics {
    include ::profile::configurations::sensu::checks::metrics
  }
}
