class profile::configurations::sensu::checks::host::puppet_server(
  $ruby_path = 'changeme',
  $ensure        = hiera('sensu::host_checks::puppet_server::ensure', 'present'),
  $slack_channel = hiera('sensu::host_checks::puppet_server::slack_channel', undef),
) {

  sensu_configuration::check { 'process-checks-puppetserver':
    ensure         => $ensure,
    command        => "check-process.rb -p puppetserver -C 1",
    slack_channel  => $slack_channel,
    # custom_message => 'The Puppet Server Service should be running',
  }

}
