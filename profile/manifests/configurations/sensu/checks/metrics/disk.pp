class profile::configurations::sensu::checks::metrics::disk(
  $ruby_path = 'changeme',
  $ensure = hiera('sensu::metrics::disk::ensure', 'present'),
  $extra_params  = hiera('sensu::host_metrics::disk::extra_params', undef)
) {

  $prefix = "sensu.${trusted['certname']}.disk"

  case downcase($::osfamily)
  {
    'windows':
      {
        sensu_configuration::metric { 'metrics-windows-disk-usage':
          ensure   => $ensure,
          command  => "${ruby_path}ruby.exe ${ruby_path}metrics-windows-disk-usage.rb --scheme ${prefix}",
          interval => 60,
          refresh  => 60,
        }
      }

      default:
      {
        sensu_configuration::metric { 'disk-metrics':
          ensure   => $ensure,
          command  => "metrics-disk-usage.rb --scheme ${prefix} ${extra_params}",
          interval => 60,
          refresh  => 60,
        }
      }
  }

}
