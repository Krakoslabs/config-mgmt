class linux_security::private::remove_local_users {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $users = [ 'administrator', 'localadmin', 'localadm' ]

  ensure_resource('User', $users, { ensure => absent })

}
