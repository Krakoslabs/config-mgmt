class sensu_configuration::handlers::metrics (
  $handler_name = 'influxdb',
  $provider     = 'sensu_api',
  $database     = hiera('sensu::influxdb::database', 'sensu'),
  $host         = hiera('sensu::influxdb::host', 'ubuntu20-1.vagrant.local'),
  $port         = hiera('sensu::influxdb::port', 8086),
  $username     = hiera('sensu::influxdb::username', 'admin'),
  $password     = hiera('sensu::influxdb::password', 'adminadminadminadmin'),
  $use_ssl      = hiera('sensu::influxdb::use_ssl', true),
  $namespace    = hiera('sensu::agent::namespace')
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
      "INFLUXDB_USER=${username}",
      "INFLUXDB_PASS=${password}",
    ],
    namespace       => $namespace,
    command         => "sensu-influxdb-handler -d ${database}",
    runtime_assets  => ['sensu/sensu-influxdb-handler'],
    provider        => $provider,
  }

}
