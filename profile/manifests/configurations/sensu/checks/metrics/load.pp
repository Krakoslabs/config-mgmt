class profile::configurations::sensu::checks::metrics::load(
  $ruby_path,
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
        sensu_configuration::metric { 'metrics-load-averages':
          ensure  => $ensure,
          command => "${ruby_path}metrics-load.rb --scheme ${prefix}",
        }
      }
  }

}
