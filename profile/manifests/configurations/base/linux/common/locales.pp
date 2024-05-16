class profile::configurations::base::linux::common::locales () {
  class { '::locales':
    default_locale => 'en_US.UTF-8',
    lc_all         => 'en_US.UTF-8',
    lc_ctype       => 'en_US.UTF-8',
    locales        => ['en_US.UTF-8 UTF-8'],
  }
  class { '::timezone':
    timezone => 'Etc/UTC',
  }
}
