class profile::configurations::sensu::server (
  $version                      = hiera('sensu::server::version', 'installed'),
  $webui_admin_password         = hiera('sensu::server::webui_admin_password', 'adminadmin'),
  $agent_entity_config_password = hiera('sensu::server::agent_entity_config_password', 'P@ssw0rd!'),
  # $enable_metrics             = hiera('sensu::metrics::enable', false)
){

  # include ::profile::applications::sensu::server
  class { '::profile::applications::sensu::server':
    version                      => $version,
    webui_admin_password         => $webui_admin_password,
    agent_entity_config_password => $agent_entity_config_password
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
