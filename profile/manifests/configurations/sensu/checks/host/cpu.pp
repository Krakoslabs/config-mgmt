class profile::configurations::sensu::checks::host::cpu(
  $ruby_path = 'changeme',
  $ensure   = hiera('sensu::host_checks::cpu::ensure', 'present'),
  $warning  = hiera('sensu::host_checks::cpu::warning', 88),
  $critical = hiera('sensu::host_checks::cpu::critical', 95),
) {

  case downcase($::osfamily) {
    'windows': {
      sensu_configuration::check { 'check-cpu':
        ensure        => $ensure,
        command       => "${ruby_path}ruby.exe ${ruby_path}check-cpu.rb -w ${warning} -c ${critical} ${extra_params}",
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }

    default: {
      sensu_configuration::check { 'cpu-checks':
        ensure        => $ensure,
        command       => "check-cpu.rb -w ${warning} -c ${critical} ${extra_params}",
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }
  }

}
