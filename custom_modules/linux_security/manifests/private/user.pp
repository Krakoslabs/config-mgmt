define linux_security::private::user(
  $ensure = 'present',
  $ssh_key = undef,
  $groups = { },
  $ssh_key_type = 'rsa',
  $shell = '/bin/bash',
  $password = '',
  $purge_ssh_keys = true,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  user { $title:
    ensure     => $ensure,
    comment    => $tittle,
    home       => "/home/${title}",
    managehome => true,
    groups     => $groups,
    shell      => $shell,
    password   => $password,
    expiry     => absent,
    purge_ssh_keys => $purge_ssh_keys
  } ->
  ssh_authorized_key { "${title}_ssh":
    ensure     => $ensure,
    user => $title,
    type => $ssh_key_type,
    key => $ssh_key,
  }

}
