class profile::applications::common::redis(
  $version,
  $password,
  $master_password,
  $master_address   = undef,
  $manage_repo      = true,
  $maxmemory        = floor(($::memorysize_mb * 0.85) * 1024 * 1024),
  $maxmemory_policy = 'allkeys-lru'
) {

  $slaveof = $master_address ? {
    undef   => undef,
    default => "${master_address} 6379"
  }

  $master_pass = $master_password ? {
    undef   => undef,
    default => $master_password,
  }

  class { '::redis':
    package_ensure   => $version,
    manage_repo      => $manage_repo,
    bind             => '0.0.0.0',
    requirepass      => $password,
    masterauth       => $master_pass,
    slaveof          => $slaveof,
    maxmemory        => $maxmemory,
    maxmemory_policy => $maxmemory_policy,
  }

  class { '::redis::sentinel':
    master_name      => pick($master_address, $::fqdn),
    failover_timeout => 15000,
  }

}
