class profile::configurations::sensu::server (
  $version                      = hiera('sensu::server::version', 'installed'),
  $password                     = hiera('sensu::server::password', undef),
  $agent_password               = hiera('sensu::server::agent_password', undef),
  $agent_entity_config_password = hiera('sensu::server::agent_entity_config_password', undef),
  $subscriptions                = hiera('sensu::agent::subscriptions', []),
  $namespace                    = hiera('sensu::agent::namespace', 'default'),
  $validate_namespaces          = hiera('sensu::server::validate_namespaces', true),
  $api_host                     = hiera('sensu::server::api_host', $::fqdn),
  $api_port                     = hiera('sensu::server::api_port', '8080'),
  $use_ssl                      = hiera('sensu::server::use_ssl', false),
  $sensu_agent_enabled          = hiera('sensu::agent::enabled', false),
  $backends                     = hiera('sensu::server::backends', []),
  $validate_api                 = hiera('sensu::agent::validate_api'),
  $validate_entity              = hiera('sensu::agent::validate_entity')
){

  class { '::profile::applications::sensu::server':
    version                      => $version,
    password                     => $password,
    agent_password               => $agent_password,
    agent_entity_config_password => $agent_entity_config_password,
    backends                     => $backends,
    subscriptions                => $subscriptions,
    namespace                    => $namespace,
    validate_namespaces          => $validate_namespaces,
    api_host                     => $api_host,
    api_port                     => $api_port,
    use_ssl                      => $use_ssl,
    sensu_agent_enabled          => $sensu_agent_enabled
  }

  # include ::profile::configurations::sensu::checks::host

  # include ::profile::configurations::sensu::checks::host
  # include ::profile::configurations::sensu::metrics::base
  # if $enable_metrics {
  #   include ::profile::configurations::sensu::checks::metrics
  #   include ::sensu_configuration::extensions
  #   include ::sensu_configuration::handlers
  #   include ::sensu_configuration::plugins
  # }

  # include ::profile::configurations::consul::services::infrastructure::sensu

}
