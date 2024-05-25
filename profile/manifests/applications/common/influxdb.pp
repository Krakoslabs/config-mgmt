class profile::applications::common::influxdb(
  $version       = '2.7.6-1',
  $admin_user,
  $admin_pass,
  $host,
  $port,
  $use_ssl = true,
  $manage_setup = true,
  $influxdb_initial_org,
  $influxdb_initial_bucket,
  $influxdb_bucket_token,
  $influxdb_bucket_port,
  $influxdb_bucket_labels
  # $cluster_nodes = [],
  # $auth_enabled  = true,
  # $data_dir      = '/var/lib/influxdb',
  # $handoff_dir   = undef,
) {

  class { '::influxdb':
    version         => $version,
    admin_user      => $admin_user,
    admin_pass      => $admin_pass,
    host            => $host,
    port            => $port,
    use_ssl         => $use_ssl,
    manage_setup    => $manage_setup,
    initial_org     => $influxdb_initial_org,
    initial_bucket  => $influxdb_initial_bucket
  }

  # TODO: (2024-06-01) - Example of influxdbv2 query from Dashboard
  # from(bucket: "sensu")
    # |> range(start: v.timeRangeStart, stop:v.timeRangeStop)

  # influxdb_org { $influxdb_initial_org:
  #   ensure  => present,
  #   token   => $influxdb_bucket_token,
  #   port    => $influxdb_bucket_port,
  #   require => Class['::influxdb']
  # } ->

  # influxdb_bucket { $influxdb_initial_bucket:
  #   ensure  => present,
  #   org     => $influxdb_initial_org,
  #   labels  => $bucket_labels,
  #   token   => $influxdb_bucket_token,
  #   port    => $influxdb_bucket_port,
  #   # require => Resource[$influxdb_initial_org]
  # }

}
