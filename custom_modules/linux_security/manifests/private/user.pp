define linux_security::private::user(
  $ensure = 'present',
  $ssh_key = undef,
  $groups = { },
  $shell = '/bin/bash'
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  accounts::user { $title:
    ensure    => $ensure,
    groups    => $groups,
    shell     => $shell,
    sshkeys   => $ssh_key,
    comment   => $title,
  }


}
