class profile::configurations::sensu::checks::host::puppet_db(
  $ruby_path = 'changeme',
  $ensure    = hiera('sensu::host_checks::puppet_db::ensure', 'present'),
) {

  sensu_configuration::check { 'process-checks-puppetdb':
    ensure         => $ensure,
    command        => "check-process.rb -p puppetdb -C 1",
    # custom_message => 'The PuppetDB Service should be running',
  }
}
