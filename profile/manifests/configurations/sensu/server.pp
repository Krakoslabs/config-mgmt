class profile::configurations::sensu::server {

  $rabbitmq_host     = hiera('sensu::server::rabbitmq::hosts')
  $rabbitmq_username = hiera('sensu::rabbitmq::username')
  $rabbitmq_password = hiera('sensu::rabbitmq::password')
  $redis_host        = hiera('sensu::redis::host')
  $redis_port        = hiera('sensu::redis::port')
  $redis_password    = hiera('sensu::redis::password')
  $subscriptions     = hiera('sensu::client::subscriptions')
  $log_level         = hiera('sensu::server::log_level')
  $enable_metrics    = hiera('sensu::metrics::enable', false)

  class { '::profile::applications::sensu::server':
    rabbitmq_host     => $rabbitmq_host,
    rabbitmq_username => $rabbitmq_username,
    rabbitmq_password => $rabbitmq_password,
    redis_host        => $redis_host,
    redis_port        => $redis_port,
    redis_password    => $redis_password,
    subscriptions     => $subscriptions,
    log_level         => $log_level,
  }

  include ::profile::configurations::sensu::checks::host

  # include ::profile::configurations::sensu::checks::host
  # include ::profile::configurations::sensu::metrics::base
  if $enable_metrics {
    include ::profile::configurations::sensu::checks::metrics
    include ::sensu_configuration::extensions
    include ::sensu_configuration::handlers
    include ::sensu_configuration::plugins
  }

  # include ::profile::configurations::consul::services::infrastructure::sensu

}
