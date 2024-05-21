class profile::configurations::sensu::checks::host::sensu_agent(
  $ruby_path = hiera('sensu::linux_ruby_path'),
  $ensure    = hiera('sensu::host_checks::sensu-agent::ensure', 'present'),
) {

  sensu_configuration::check { 'check-process-sensu-agent':
    ensure         => $ensure,
    command        => "${ruby_path}check-process.rb -p sensu-agent -C 1",
    # custom_message => 'The PuppetDB Service should be running',
  }
}
