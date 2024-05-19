class profile::configurations::puppet::server (
  $use_puppet_db         = hiera('puppet::server::use_puppet_db', false),
  $puppet_db_server      = hiera('puppet::server::db_hostname', undef),
  $ensure_cron           = hiera('puppet::server::cron', 'absent'),
  $retries_before_slack  = hiera('puppet::server::slack_attempt_limit', 3),
  $branch                = hiera('puppet::server::branch', 'production'),
  $eyaml_key_content     = hiera('puppet::server::encryption_key', 'test2'),
  $ssh_key_content       = hiera('puppet::server::github_ssh_key', 'test'),
  $puppet_server_address = hiera('puppet::server::address'),
  $certificate_name      = hiera('puppet::server::certificate_name', 'puppetserver.vagrant.local'),
) {

  if $facts['fqdn'] == 'puppetserver.vagrant.local' {
    $environment = 'vagrant'
  } else {
    $environment = $::environment
  }

  class { '::profile::applications::puppet::server':
    server               => $puppet_server_address,
    certificate_name     => $certificate_name,
    environment          => $environment,
    use_puppet_db        => $use_puppet_db,
    puppet_db_server     => $puppet_db_server,
    ensure_cron          => $ensure_cron,
    retries_before_slack => $retries_before_slack,
    branch               => $branch,
    eyaml_key_content    => $eyaml_key_content,
    ssh_key_content      => $ssh_key_content,
  }

  # include ::profile::configurations::sensu::checks::host::puppet_server

}
