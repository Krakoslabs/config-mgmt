class role::infrastructure::monitoring::sensu::server {

  ensure_resource('Class', '::profile::configurations::base::linux::base', { sensu_agent_enabled => false })

  # $service_checker = hiera('sensu::service::service_checker', false)
  include ::profile::configurations::sensu::server


  # if $::environment == 'vagrant' and $service_checker {
  #   include ::role::infrastructure::monitoring::sensu::service_checker
  # }

  # include ::profile::configurations::sensu::uchiwa

}
