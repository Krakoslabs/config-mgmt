class profile::configurations::sensu::checks::host::puppet_db(
  $ruby_path = hiera('sensu::linux_ruby_path'),
  $ensure    = hiera('sensu::host_checks::puppet_db::ensure', 'present'),
) {

  sensu_configuration::check { 'check-process-puppetdb':
    ensure         => $ensure,
    command        => "${ruby_path}check-process.rb -p puppetdb -C 1",
    # custom_message => 'The PuppetDB Service should be running',
  }
}
