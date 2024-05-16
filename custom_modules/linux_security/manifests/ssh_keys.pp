define linux_security::ssh_keys($users) {

  if !empty($users) {
    ensure_resources('linux_security::private::user', $users, {})
  }

}
