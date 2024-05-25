class profile::configurations::sensu::checks::metrics {

  case downcase($::osfamily) {
    'windows': {
      $ruby_path = hiera('sensu::windows_ruby_path')
    }

    default: {
      $ruby_path = hiera('sensu::linux_ruby_path')
    }
  }

  class { '::profile::configurations::sensu::checks::metrics::cpu': }

  class { '::profile::configurations::sensu::checks::metrics::load': }

  class { '::profile::configurations::sensu::checks::metrics::memory': }

  class { '::profile::configurations::sensu::checks::metrics::disk':  }

  # class { '::profile::configurations::sensu::checks::metrics::network':
  #   ruby_path => $ruby_path,
  # }

}
