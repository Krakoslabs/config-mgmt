class puppet_server::repository(
  $working_directory,
  $ssh_directory,
  $user,
  $group,
  $service_name,
  $eyaml_key_content,
  $ssh_key_content,
) {

  assert_private()

  $krk_folder              = '/var/krk'
  $ssh_key_file           = "${ssh_directory}/id_rsa"
  $eyaml_key_file         = "${working_directory}/keys/${::environment}_private_key.pkcs7.pem"
  $repository_init_script = "${krk_folder}/puppet-repository-init.sh"
  $lock_file              = "${krk_folder}/.puppet_repository_configured"
  $repository_url         = 'git@github.com:ve-interactive/puppet.git'


  # Configure the SSH Key
  file { $ssh_directory:
    ensure => directory,
    owner  => $user,
    group  => $group,
    #require => File[$krk_folder],
  }

  file { $ssh_key_file:
    ensure  => file,
    content => $ssh_key_content,
    mode    => '0600',
    owner   => $user,
    group   => $group,
    require => File[$ssh_directory],
  }

  ## Run the Repository Initialisation Script
  #file { $repository_init_script:
  #  ensure  => file,
  #  content => template('puppet_server/repository-setup.sh.erb'),
  #  mode    => '0700',
  #  owner   => $user,
  #  group   => $group,
  #  require => File[$ssh_key_file],
  #}

  #exec { 'configure-puppet-repository':
  #  command => $repository_init_script,
  #  creates => $lock_file,
  #  require => File[$repository_init_script],
  #}

  ## Hiera Eyaml Key
  #file { $eyaml_key_file:
  #  content => $eyaml_key_content,
  #  owner   => 'root',
  #  group   => 'root',
  #  require => Exec['configure-puppet-repository'],
  #}
}
