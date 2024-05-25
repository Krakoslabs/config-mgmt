class profile::configurations::sensu::checks::host{

  case downcase($::osfamily) {
    'windows': {
      $ruby_path = hiera('sensu::windows_ruby_path')
    }

    default: {
      $ruby_path = hiera('sensu::linux_ruby_path')
    }
  }

  include ::sensu_configuration::assets::base

  class { '::profile::configurations::sensu::checks::host::cpu': }

  class { '::profile::configurations::sensu::checks::host::load': }

  class { '::profile::configurations::sensu::checks::host::memory': }

  class { '::profile::configurations::sensu::checks::host::disk': }

  # class { '::profile::configurations::sensu::checks::host::puppet':
  #   ruby_path => $ruby_path,
  # }

}
