class profile::configurations::sensu::checks::metrics::cpu(
  $ruby_path,
  $ensure = hiera('sensu::metrics::cpu::ensure', 'present'),
) {

  $prefix = "sensu.${trusted['certname']}.cpu"

  case downcase($::osfamily)
  {
    'windows':
      {
        # TODO: implement me
      }

      default:
      {
        sensu_configuration::metric { 'metrics-cpu':
          ensure  => $ensure,
          command => "${ruby_path}metrics-cpu.rb --scheme ${prefix}",
        }
      }
  }

}
