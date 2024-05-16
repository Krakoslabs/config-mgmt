class linux_security {

  $enable_ssh_only_logins = hiera('linux_security::enable_ssh_only_logins')

  include ::linux_security::private::sudoers

  if $enable_ssh_only_logins {
    class { '::linux_security::private::remove_local_users':
      require => Class['::linux_security::private::sudoers'],
    }
    class { '::linux_security::private::disable_password_login':
      require => Class['::linux_security::private::remove_local_users'],
    }
  }

}
