class profile::configurations::puppet::agent (
  $server            = hiera('puppet::server::address', 'puppetserver.vagrant.local'),
  $version           = hiera('puppet::agent::version', 7.30.0),
  $runinterval       = hiera('puppet::agent::runinterval', 300),
  $interval_rand_max = hiera('puppet::agent::interval_rand_max', 150)
) {

  class { '::puppetagent':
    server      => $server,
    environment => $::environment,
    runinterval => $runinterval + seeded_rand($interval_rand_max, $::fqdn),
    version     => $version,
  }

}
