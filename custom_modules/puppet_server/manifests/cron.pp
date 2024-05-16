class puppet_server::cron(
  $ensure,
  $service_name,
  $working_directory,
  $retries_before_slack,
  $branch,
) {

  assert_private()

  $tasks_directory     = '/var/ve/tasks'
  $release_file_name   = 'puppet_server_release.sh'
  $release_script_path = "${tasks_directory}/${release_file_name}"
  $username            = 'root'
  $release_var_path    = '/var/log/puppet_deployments'
  $release_log_file    = 'deployment.log'

  ensure_resource('File', $tasks_directory, { ensure => directory, owner => $username } )

  file { $release_script_path:
    ensure  => $ensure,
    content => template('puppet_server/update-cron.sh.erb'),
    owner   => $username,
    mode    => '0755',
    require => File[$tasks_directory],
  }

  cron { "run-${release_file_name}-every-5-minutes":
    ensure  => $ensure,
    command => "${release_script_path} ${branch}",
    hour    => '*',
    minute  => '*/5',
    user    => $username,
    require => File[$release_script_path],
  }

  logrotate::rule { 'puppet_server_release':
    path         => "${release_var_path}/${release_log_file}",
    dateext      => true,
    rotate_every => 'day',
    rotate       => 10,
    create       => true,
    create_mode  => '0644',
    create_owner => $username,
    create_group => 'root',
    postrotate   => 'service rsyslog restart >/dev/null 2>&1 || true',
    require      => Cron["run-${release_file_name}-every-5-minutes"],
  }

}
