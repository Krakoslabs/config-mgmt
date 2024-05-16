class puppet_server::config(
  $working_directory,
  $allowed_domains,
  $service_name,
  $certificate_name,
  $environment,
  $server_address,
  $use_puppet_db,
) {

  assert_private()
  file { "${working_directory}/autosign.conf":
    ensure  => file,
    content => template('puppet_server/autosign.conf.erb'),
    notify  => Service[$service_name],
  }

  file { "${working_directory}/puppet.conf":
    ensure  => file,
    content => template('puppet_server/puppet.conf.erb'),
    notify  => Service[$service_name],
  }

}
