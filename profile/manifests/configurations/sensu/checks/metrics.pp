class profile::configurations::sensu::checks::metrics {

  case downcase($::osfamily) {
    'windows': {
      $ruby_path = hiera('sensu::windows_ruby_path')
    }

    default: {
      $ruby_path = hiera('sensu::linux_ruby_path')
    }
  }

  class { '::profile::configurations::sensu::checks::metrics::cpu':
    ruby_path => $ruby_path,
  }

  # class { '::profile::configurations::sensu::checks::metrics::disk':
  #   ruby_path => $ruby_path,
  # }

  class { '::profile::configurations::sensu::checks::metrics::load':
    ruby_path => $ruby_path,
  }

  class { '::profile::configurations::sensu::checks::metrics::memory':
    ruby_path => $ruby_path,
  }

  # class { '::profile::configurations::sensu::checks::metrics::network':
  #   ruby_path => $ruby_path,
  # }

}
