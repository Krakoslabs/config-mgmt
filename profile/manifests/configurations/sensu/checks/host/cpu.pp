class profile::configurations::sensu::checks::host::cpu(
  $ruby_path,
  $ensure   = hiera('sensu::host_checks::cpu::ensure', 'absent'),
  $warning  = hiera('sensu::host_checks::cpu::warning', 88),
  $critical = hiera('sensu::host_checks::cpu::critical', 95),
) {

  case downcase($::osfamily)
  {
    'windows':
      {
        # TODO: implement me
      }

      default:
      {
        sensu_configuration::check { 'check-cpu':
          ensure   => $ensure,
          command  => "${ruby_path}check-cpu.rb -w ${warning} -c ${critical}",
        }
      }
  }
}
