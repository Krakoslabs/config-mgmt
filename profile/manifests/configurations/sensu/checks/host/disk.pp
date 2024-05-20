class profile::configurations::sensu::checks::host::disk(
  $ruby_path,
  $ensure        = hiera('sensu::host_checks::disk::ensure', 'present'),
  $warning       = hiera('sensu::host_checks::disk::warning', 90),
  $critical      = hiera('sensu::host_checks::disk::critical', 95),
  $slack_channel = hiera('sensu::host_checks::disk::slack_channel', undef),
  $opsgenie_team = hiera('sensu::host_checks::disk::opsgenie_team', undef),
  $extra_params  = hiera('sensu::host_checks::disk::extra_params', undef)
) {

  case downcase($::osfamily) {
    'windows': {
      sensu_configuration::check { 'check-disk-usage':
        ensure        => $ensure,
        command       => "${ruby_path}ruby.exe ${ruby_path}check-windows-disk.rb -w ${warning} -c ${critical} ${extra_params}",
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }

    default: {
      sensu_configuration::check { 'check-disk-usage':
        ensure        => $ensure,
        command       => "${ruby_path}check-disk-usage.rb -w ${warning} -c ${critical} ${extra_params}",
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }
  }

}
