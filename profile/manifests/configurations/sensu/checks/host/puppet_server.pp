class profile::configurations::sensu::checks::host::puppet_server(
  $ruby_path     = hiera('sensu::linux_ruby_path'),
  $ensure        = hiera('sensu::host_checks::puppet_server::ensure', 'present'),
  $slack_channel = hiera('sensu::host_checks::puppet_server::slack_channel', undef),
) {

  sensu_configuration::check { 'check-process-puppetserver':
    ensure         => $ensure,
    command        => "${ruby_path}check-process.rb -p puppetserver -C 1",
    slack_channel  => $slack_channel,
    # custom_message => 'The Puppet Server Service should be running',
  }

}
