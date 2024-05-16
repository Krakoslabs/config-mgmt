class puppet_server(
  $server,
  $certificate_name,
  $environment,
  $use_puppet_db,
  $puppet_db_server,
  $puppet_termini_version,
  $working_directory,
  $allowed_domains,
  $ensure_cron,
  $retries_before_slack,
  $branch,
  $eyaml_key_content,
  $ssh_key_content,
  $puppet_db_ssl_port,
) {

  # validate_string($server)
  # validate_string($certificate_name)
  # validate_string($environment)
  # validate_string($working_directory)
  # validate_bool($use_puppet_db)

  # if ($use_puppet_db == true) {
  #   validate_string($puppet_db_server)
  #   validate_string($puppet_termini_version)
  # }

  # validate_string($eyaml_key_content)
  # validate_string($ssh_key_content)

  $service_name  = 'puppetserver'
  $ssh_directory = '/root/.ssh'
  $user          = 'root'
  $group         = 'root'

  include ::puppet_server::install

  # class { '::puppet_server::repository':
  #   working_directory => $working_directory,
  #   ssh_directory     => $ssh_directory,
  #   user              => $user,
  #   group             => $group,
  #   service_name      => $service_name,
  #   eyaml_key_content => $eyaml_key_content,
  #   ssh_key_content   => $ssh_key_content,
  #   require           => Class['Puppet_server::Install'],
  # }

  class { '::puppet_server::config':
    working_directory => $working_directory,
    allowed_domains   => $allowed_domains,
    server_address    => $server,
    certificate_name  => $certificate_name,
    use_puppet_db     => $use_puppet_db,
    service_name      => $service_name,
    environment       => $environment,
#    require           => Class['Puppet_server::Repository'],
  }

  #class { '::puppet_server::certificates':
  #  working_directory => $working_directory,
  #  server_address    => $server,
  #  certificate_name  => $certificate_name,
  #  user              => $user,
  #  group             => $group,
  #  require           => Class['Puppet_server::Config'],
  #}

  class { '::puppet_server::puppet_db':
    working_directory      => $working_directory,
    puppet_termini_version => $puppet_termini_version,
    enabled                => $use_puppet_db,
    port                   => $puppet_db_ssl_port,
    server                 => $puppet_db_server,
    service_name           => $service_name,
    require                => Class['Puppet_server::Config'],
  }

  #class { '::puppet_server::cron':
  #  ensure               => $ensure_cron,
  #  service_name         => $service_name,
  #  working_directory    => $working_directory,
  #  retries_before_slack => $retries_before_slack,
  #  branch               => $branch,
  #  require              => Class['Puppet_server::Puppet_db'],
  #}

}
