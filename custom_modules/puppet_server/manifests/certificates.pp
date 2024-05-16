class puppet_server::certificates(
  $working_directory,
  $server_address,
  $certificate_name,
  $user,
  $group,
) {

  assert_private()

  $ve_folder               = '/var/ve'
  $certificate_init_script = "${ve_folder}/puppet-certificates-init.sh"
  $lock_file               = "${ve_folder}/.puppet_certificates_configured"

  # Run the Certificate Initialisation Script
  file { $certificate_init_script:
    ensure  => file,
    content => template('puppet_server/certificate-setup.sh.erb'),
    mode    => '0700',
    owner   => $user,
    group   => $group,
    require => File[$ve_folder],
  }

  if downcase($certificate_name) != downcase($::fqdn) {
    exec { 'configure-puppet-certificates':
      command => $certificate_init_script,
      creates => $lock_file,
      require => File[$certificate_init_script],
    }
  }

}
