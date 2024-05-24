class profile::configurations::sensu::checks::metrics::memory(
  $ruby_path,
  $ensure = hiera('sensu::metrics::memory::ensure', 'present'),
) {

  $prefix = "sensu.${trusted['certname']}.memory"

  case downcase($::osfamily)
  {
    'windows':
      {
        sensu_configuration::metric { 'metrics-windows-memory':
          ensure  => $ensure,
          command => "${ruby_path}ruby.exe ${ruby_path}metrics-windows-ram-usage.rb --scheme ${prefix}",
        }
      }

      default:
      {
        sensu_configuration::metric { 'metrics-memory':
          ensure  => $ensure,
          command => "${ruby_path}metrics-memory.rb --scheme ${prefix}",
        }

        sensu_configuration::metric { 'metrics-memory-percentage':
          ensure  => $ensure,
          command => "${ruby_path}metrics-memory-percent.rb --scheme ${prefix}.percent",
        }
      }
  }

}
