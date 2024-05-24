class sensu_configuration::handlers::metrics (
  $handler_name = 'influxdb',
  $provider     = 'sensu_api',
  $database     = hiera('sensu::influxdb::database', 'sensu'),
  $host         = hiera('sensu::influxdb::host', 'ubuntu20-3.vagrant.local'),
  $port         = hiera('sensu::influxdb::port', 8086),
  $username     = hiera('sensu::influxdb::username', 'admin'),
  $password     = hiera('sensu::influxdb::password', 'adminadminadminadmin'),
  $use_ssl      = hiera('sensu::influxdb::use_ssl', true),
  $namespace    = hiera('sensu::agent::namespace'),
  $bucket = 'sensu',
  $organization = 'appfire'
) {

  $addr = "https://${$host}:${port}"
  sensu_bonsai_asset { 'sensu/sensu-influxdb-handler':
    ensure  => 'present',
    version => '4.0.0',
  }

  sensu_handler { $handler_name:
    ensure          => 'present',
    type            => 'pipe',
    env_vars       => [
      "INFLUXDB_ADDR=${addr}",
      "INFLUXDB_BUCKET=${bucket}",
      "INFLUXDB_ORG=${organization}",
      "INFLUXDB_TOKEN=-g2edgXVH-Ru66TYjtOPlJFfHwXXeBRn8RFwfGEl0wltrnSzm2FnHalcQQKUjf8UqkrP84pR5wvA1WBMPYs0Ag=="
    ],
    namespace       => $namespace,
    command         => "sensu-influxdb-handler",
    runtime_assets  => ['sensu/sensu-influxdb-handler'],
    provider        => $provider,
    timeout         => $timeout
  }

}
