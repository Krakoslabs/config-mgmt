class profile::configurations::sensu::checks::host::load(
  $ruby_path = 'changeme',
  $ensure                  = hiera('sensu::host_checks::load::ensure', 'present'),
  $warning_percentage_win  = hiera('sensu::host_checks::load::warning', 80),
  $critical_percentage_win = hiera('sensu::host_checks::load::critical', 90),
  $warning_load_averages   = hiera('sensu::host_checks::load::warning_average', '3.0,2.0,1.5'),
  $critical_load_averages  = hiera('sensu::host_checks::load::critical_average', '5.0,3.0,2.0'),
  $handlers                = hiera('sensu::host_checks::load::handlers', undef),
  $slack_channel           = hiera('sensu::host_checks::load::slack_channel', undef),
  $opsgenie_team           = hiera('sensu::host_checks::load::opsgenie_team', undef),
) {

  case downcase($::osfamily) {
    'windows': {
      sensu_configuration::check { 'check-windows-load':
        ensure => 'absent',
        command  => '',
      }
    }

    default: {
      sensu_configuration::check { 'load-checks':
        ensure        => $ensure,
        command       => "check-load.rb -w ${warning_load_averages} -c ${critical_load_averages}",
        handlers      => $handlers,
        slack_channel => $slack_channel,
        opsgenie_team => $opsgenie_team,
      }
    }
  }
}
