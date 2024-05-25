class profile::configurations::databases::metrics::influxdb (
  $version                 = hiera('sensu::influxdb::version', '1.6.4-1'),
  $influxdb_admin_user     = hiera('sensu::influxdb::admin_user'),
  $influxdb_admin_pass     = hiera('sensu::influxdb::admin_pass'),
  $influxdb_host           = hiera('sensu::influxdb::host'),
  $influxdb_port           = hiera('sensu::influxdb::port'),
  $influxdb_use_ssl        = hiera('sensu::influxdb::use_ssl', true),
  $influxdb_initial_org    = hiera('sensu::influxdb::initial_org', 'myorg'),
  $influxdb_initial_bucket = hiera('sensu::influxdb::initial_bucket', 'bucket_test'),
  $influxdb_bucket_token   = hiera('sensu::influxdb::influxdb_bucket_token', 'my_bucket_token'),
  $influxdb_bucket_port    = hiera('sensu::influxdb::influxdb_bucket_port', 1234),
  $bucket_labels           = hiera('sensu::influxdb::bucket_labels', ['monitoring']),
) {

  $sensu_agent_enabled = hiera('sensu::agent::enabled')

  class { '::profile::applications::common::influxdb':
    version                 => $version,
    admin_user              => $influxdb_admin_user,
    admin_pass              => Sensitive($influxdb_admin_pass),
    host                    => $influxdb_host,
    port                    => $influxdb_port,
    use_ssl                 => $influxdb_use_ssl,
    influxdb_initial_org    => $influxdb_initial_org,
    influxdb_initial_bucket => $influxdb_initial_bucket,
    influxdb_bucket_token   => Sensitive($influxdb_bucket_token),
    influxdb_bucket_port    => $influxdb_bucket_port,
    influxdb_bucket_labels  => $influxdb_bucket_labels
  }

  if $sensu_agent_enabled {
    include ::profile::configurations::sensu::checks::host::influxdb
  }

}
