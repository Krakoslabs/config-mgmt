class profile::configurations::sensu::checks::metrics::cpu(
  $ruby_path = 'changeme',
  $ensure = hiera('sensu::metrics::cpu::ensure', 'present'),
) {

  $prefix = "sensu.${trusted['certname']}.cpu"

  case downcase($::osfamily)
  {
    'windows':
      {
        # TODO: (2024-06-01) - implement me
      }

      default:
      {
        sensu_configuration::metric { 'cpu-metrics':
          ensure  => $ensure,
          command => "metrics-cpu.rb --scheme ${prefix}",
        }
      }
  }

}
