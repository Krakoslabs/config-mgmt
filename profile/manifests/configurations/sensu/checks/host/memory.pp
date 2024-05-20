class profile::configurations::sensu::checks::host::memory(
  $ruby_path,
  $ensure        = hiera('sensu::host_checks::memory::ensure', 'present'),
  $warning       = hiera('sensu::host_checks::memory::warning', 88),
  $critical      = hiera('sensu::host_checks::memory::critical', 95),
  $handlers      = hiera('sensu::host_checks::memory::handlers', undef),
  $slack_channel = hiera('sensu::host_checks::memory::slack_channel', undef),
  $opsgenie_team = hiera('sensu::host_checks::memory::opsgenie_team', undef),
) {

  case downcase($::osfamily) {
    'windows': {
      sensu_configuration::check { 'check-windows-memory-percent':
        ensure        => $ensure,
        command       => "${ruby_path}ruby.exe ${ruby_path}check-windows-ram.rb -w ${warning} -c ${critical}",
        handlers      => $handlers,
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }

    default: {
      sensu_configuration::check { 'check-memory-percent':
        ensure        => $ensure,
        command       => "${ruby_path}check-memory-percent.rb -w ${warning} -c ${critical}",
        handlers      => $handlers,
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }
  }



}
