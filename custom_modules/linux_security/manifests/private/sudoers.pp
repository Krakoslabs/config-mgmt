class linux_security::private::sudoers (
  $is_docker_host  = false,
  $is_vagrant_host = false,
){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $os_name = downcase($::osfamily)

  file { '/etc/sudoers':
    ensure  => file,
    content => template('linux_security/sudoers.erb'),
    mode    => '0440',
    owner   => 'root',
    group   => 'root',
  }

}
