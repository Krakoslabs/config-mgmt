class profile::configurations::redis::sensu {

  $version         = hiera('sensu::redis::version')
  $password        = hiera('sensu::redis::password')
  $master_password = hiera('sensu::redis::master_password', undef)
  $master_address  = hiera('sensu::redis::master_address', undef)

  $master_fqdn = $master_address ? {
    $::fqdn => undef,
    default => $master_address,
  }

  $tags = $master_address ? {
    $::fqdn => ['master'],
    default => ['slave'],
  }

  class { '::profile::applications::common::redis':
    version         => $version,
    password        => $password,
    master_password => $master_password,
    master_address  => $master_fqdn,
  }

  # include ::profile::configurations::sensu::checks::host::redis
  # include ::profile::configurations::consul::services::infrastructure::redis
  #include ::profile::configurations::sensu::metrics::redis

}
