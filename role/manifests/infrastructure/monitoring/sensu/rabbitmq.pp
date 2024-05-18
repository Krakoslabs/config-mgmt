class role::infrastructure::monitoring::sensu::rabbitmq {

  ensure_resource('Class', '::profile::configurations::base::linux::base', { sensu => false })
  include ::profile::configurations::rabbitmq::sensu

}
