class role::infrastructure::puppet::server {

  class { '::profile::configurations::base::linux::base':
    puppetagent => false,
  }
  include ::profile::configurations::puppet::server

}
