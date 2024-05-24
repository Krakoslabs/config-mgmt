class profile::configurations::sensu::checks::host{

  case downcase($::osfamily) {
    'windows': {
      $ruby_path = hiera('sensu::windows_ruby_path')
    }

    default: {
      $ruby_path = hiera('sensu::linux_ruby_path')
    }
  }

  class { '::profile::configurations::sensu::checks::host::cpu':
    ruby_path => $ruby_path,
  }

  class { '::profile::configurations::sensu::checks::host::load':
    ruby_path => $ruby_path,
  }

  class { '::profile::configurations::sensu::checks::host::memory':
    ruby_path => $ruby_path,
  }

  # class { '::profile::configurations::sensu::checks::host::disk':
  #   ruby_path => $ruby_path,
  # }

  # class { '::profile::configurations::sensu::checks::host::puppet':
  #   ruby_path => $ruby_path,
  # }

}
