class linux_security::private::disable_password_login {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case downcase($::osfamily) {

    'debian': {
      $ssh_service_name = 'ssh'
    }

    'redhat': {
      $ssh_service_name = 'sshd'
    }

    default: {
      fail("The OS Family '${::osfamily}' is not yet supported")
    }

  }

  ini_setting { 'disable_password_login':
    ensure            => present,
    path              => '/etc/ssh/sshd_config',
    section           => '',
    key_val_separator => ' ',
    setting           => 'PasswordAuthentication',
    value             => 'no',
    notify            => Service[$ssh_service_name],
  }

  service { $ssh_service_name:
    ensure => 'running',
  }

}
