class profile::configurations::puppet::agent {

  $server            = hiera('puppet::server::address')
  $version           = hiera('puppet::agent::version')
  $runinterval       = hiera('puppet::agent::runinterval')
  $interval_rand_max = hiera('puppet::agent::interval_rand_max')

  class { '::puppetagent':
    server      => $server,
    environment => $::environment,
    runinterval => $runinterval + seeded_rand($interval_rand_max, $::fqdn),
    version     => $version,
  }

}
