class profile::configurations::sensu::server (
  $version                      = hiera('sensu::server::version', 'installed'),
  $password                     = hiera('sensu::server::password', 'adminadmin'),
  $agent_entity_config_password = hiera('sensu::server::agent_entity_config_password', 'P@ssw0rd!'),
  $subscriptions                = hiera('sensu::agent::subscriptions', []),
  $namespace                    = hiera('sensu::server::namespace', 'sensu-system'),
  $validate_namespaces          = hiera('sensu::server::validate_namespaces', true),
  $api_host                     = hiera('sensu::server::api_host', $::fqdn),
  $api_port                     = hiera('sensu::server::api_port', '8080'),
){

  # include ::profile::applications::sensu::server
  class { '::profile::applications::sensu::server':
    version                      => $version,
    password                     => $password,
    agent_entity_config_password => $agent_entity_config_password,
    backends                     => $backends,
    subscriptions                => $subscriptions,
    namespace                    => $namespace,
    validate_namespaces          => $validate_namespaces,
    api_host                     => $api_host,
    api_port                     => $api_port,
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
