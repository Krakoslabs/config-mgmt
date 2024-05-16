class profile::applications::puppet::server(
  $server,
  $certificate_name,
  $environment,
  $use_puppet_db,
  $puppet_db_server,
  $ensure_cron,
  $retries_before_slack,
  $branch,
  $eyaml_key_content,
  $ssh_key_content,
  $puppet_termini_version = '8.6.0',
  $working_directory = hiera('puppet::server::working_directory', undef),
  $allowed_domains = hiera('puppet::server::allowed_domains', undef),
  $puppet_db_ssl_port = hiera('puppet::dashboard::puppetdb::ssl_port', undef),
) {

  # validate_bool($use_puppet_db)

  class { 'puppetserver':
    certname           => $trusted['certname'],
    version            => '7.17.0-1focal',
    autosign           => true,
    java_args          => '-Xms2g -Xmx2g -XX:MaxPermSize=256m',
    agent_version      => '7.30.0-1focal',
    puppetdb           => $use_puppet_db,
    puppetdb_version   => '5.1.3-1puppetlabs1',
    puppetdb_server    => $puppet_db_server,
    puppetdb_port      => 8081,
    system_config_path => '/etc/default'
  }

  # class { '::puppet_server':
  #   server                 => $server,
  #   certificate_name       => $certificate_name,
  #   environment            => $environment,
  #   use_puppet_db          => $use_puppet_db,
  #   puppet_db_server       => $puppet_db_server,
  #   puppet_db_ssl_port     => $puppet_db_ssl_port,
  #   puppet_termini_version => $puppet_termini_version,
  #   working_directory      => $working_directory,
  #   allowed_domains        => $allowed_domains,
  #   ensure_cron            => $ensure_cron,
  #   retries_before_slack   => $retries_before_slack,
  #   branch                 => $branch,
  #   eyaml_key_content      => $eyaml_key_content,
  #   ssh_key_content        => $ssh_key_content,
  # }
}
