class profile::configurations::sensu::checks::host::influxdb(
  $ruby_path = 'changeme',
  $ensure        = hiera('sensu::host_checks::influxdb::ensure', 'present'),
  $slack_channel = hiera('sensu::host_checks::influxdb::slack_channel', undef),
) {

  sensu_configuration::check { 'process-checks-influxd':
    ensure         => $ensure,
    command        => "check-process.rb -p influxd -C 1",
    slack_channel  => $slack_channel,
    # custom_message => 'The Puppet Server Service should be running',
  }

}
