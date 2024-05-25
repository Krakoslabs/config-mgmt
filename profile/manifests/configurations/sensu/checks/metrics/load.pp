class profile::configurations::sensu::checks::metrics::load(
  $ruby_path = 'changeme',
  $ensure = hiera('sensu::metrics::load::ensure', 'present'),
) {

  $prefix = "sensu.${trusted['certname']}.load"

  case downcase($::osfamily)
  {
    'windows':
      {
        sensu_configuration::metric { 'metrics-windows-cpu-load':
          ensure  => $ensure,
          command => "${ruby_path}ruby.exe ${ruby_path}metrics-windows-cpu-load.rb --scheme ${prefix}",
        }
      }

      default:
      {
        sensu_configuration::metric { 'load-metrics':
          ensure  => $ensure,
          command => "metrics-load.rb --scheme ${prefix}",
        }
      }
  }

}
