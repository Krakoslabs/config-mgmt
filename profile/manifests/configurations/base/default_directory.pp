class profile::configurations::base::default_directory () {
  file { 'default_directory':
    ensure => directory,
    path   => $::default_directory,
  }
}
