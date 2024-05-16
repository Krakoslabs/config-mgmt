class puppetagent(
  $server,
  $environment,
  $runinterval,
  $version,
  $puppet_agent_path  = '/etc/puppetlabs/puppet',
  $report             = true,
  $splay              = false,
  $usecacheonfailure  = false,
  $ssldir             = '/etc/puppetlabs/puppet/ssl',
  $rundir             = '/var/run/puppet',
) {

  file { "${puppet_agent_path}/puppet.conf":
    ensure  => present,
    content => template('puppetagent/puppet.conf.erb'),
    owner   => root,
    mode    => '0744',
  }

  class { 'puppet_agent':
    package_version => $version,
    is_pe           => false,
    service_names   => ['puppet'],
    require         => File["${puppet_agent_path}/puppet.conf"],
  }

}
