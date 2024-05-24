class profile::configurations::sensu::checks::metrics::disk(
  $ruby_path,
  $ensure = hiera('sensu::metrics::disk::ensure', 'present'),
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
        sensu_configuration::metric { 'metrics-disk-usage':
          ensure   => $ensure,
          command  => "${ruby_path}metrics-disk-usage.rb --scheme ${prefix}",
          interval => 60,
          refresh  => 60,
        }
      }
  }

}
