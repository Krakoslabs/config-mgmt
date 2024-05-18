class role::infrastructure::monitoring::sensu::server {

  ensure_resource('Class', '::profile::configurations::base::linux::base', { sensu => false })

  if $::environment == 'vagrant' {
    include ::profile::configurations::rabbitmq::sensu
    include ::profile::configurations::redis::sensu
  }

  $service_checker = hiera('sensu::service::service_checker', false)

  # if $::environment == 'vagrant' and $service_checker {
  #   include ::role::infrastructure::monitoring::sensu::service_checker
  # }

  include ::profile::configurations::sensu::server
  # include ::profile::configurations::sensu::uchiwa

}
