class sensu_configuration::handlers::metrics (
  $handler_name = 'influxdb',
  $provider     = 'sensu_api',
  $host         = hiera('sensu::influxdb::host', 'ubuntu20-3.vagrant.local'),
  $port         = hiera('sensu::influxdb::port', 8086),
  $use_ssl      = hiera('sensu::influxdb::use_ssl', true),
  $namespace    = hiera('sensu::agent::namespace'),
  $organization = hiera('sensu::influxdb::initial_org', 'appfire'),
  $bucket       = hiera('sensu::influxdb::bucket', 'sensu')
) {

  # TODO: (2024-06-01) - Remove flag "--insecure-skip-verify" when we will create the correct certificate
  if $use_ssl {
    $addr = "https://${$host}:${port}"
    $command = "sensu-influxdb-handler --insecure-skip-verify"
  } else {
    $addr = "http://${$host}:${port}"
    $command = "sensu-influxdb-handler --insecure-skip-verify"
  }

  sensu_bonsai_asset { 'sensu/sensu-influxdb-handler':
    ensure    => 'present',
    version   => '4.0.0',
    namespace => $namespace
  }

  # TODO: (2024-06-01) - Create an influxdb token for sensu bucket
  sensu_handler { $handler_name:
    ensure          => 'present',
    type            => 'pipe',
    env_vars        => [
      "INFLUXDB_ADDR=${addr}",
      "INFLUXDB_BUCKET=${bucket}",
      "INFLUXDB_ORG=${organization}",
      "INFLUXDB_TOKEN=cqvJ77uIbRkOVClYhtRqe_l_lNmQnsFjbMeRiXEJX9ZkHv6zFZz8bVGlXKj_8SUQMOcdMPXeVCb-cqVwBfex_w=="
    ],
    namespace       => $namespace,
    command         => $command,
    runtime_assets  => ['sensu/sensu-influxdb-handler'],
    provider        => $provider,
    timeout         => $timeout
  }

}
