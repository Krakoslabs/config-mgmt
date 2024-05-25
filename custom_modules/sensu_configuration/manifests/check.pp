define sensu_configuration::check(
  $ensure            = 'present',
  $command,
  $provider          = 'sensu_api',
  $custom_message    = undef,
  $slack_channel     = undef,
  $teams_webhook     = undef,
  $opsgenie_team     = undef,
  $handlers          = undef,
  $interval          = hiera('sensu::default_interval'),
  $interval_rand_max = hiera('sensu::default_interval_rand_max'),
  $occurrences       = hiera('sensu::default_occurrences'),
  $refresh           = hiera('sensu::default_refresh'),
  $namespace         = hiera('sensu::agent::namespace')
) {

  # ensure_resource('Class', 'sensu_configuration::plugins::base', { })

  if $handlers != undef {
    $handler = $handlers
  } else {
    $handler = hiera('sensu::default_check_handlers', undef)
  }

  if $custom_message != undef {
    $message = {
      notification => $custom_message,
    }
  } else {
    $message = { }
  }

  if $slack_channel != undef {
    $slack = {
      slack_channel => $slack_channel,
    }
  } else {
    $slack = { }
  }

  if $teams_webhook != undef {
    $teams = {
      teams_webhook => $teams_webhook,
    }
  } else {
    $teams = { }
  }

  if $opsgenie_team != undef {
    $opsgenie = {
      'opsgenie' => {
        'teams' => $opsgenie_team,
      },
    }
  } else {
    $opsgenie = {
    }
  }

  $custom = merge($message, $slack, $opsgenie, $teams)

  # sensu_check { "check-cpu-${facts['fqdn']}":
  #   ensure        => 'absent',
  #   command       => 'check-cpu.sh -w 75 -c 90',
  #   interval      => 60,
  #   subscriptions => ["entity:${facts['fqdn']}"],
  #   provider      => 'sensu_api',
  # }

  # $extra_subscriptions = [downcase($::kernel), downcase($::environment), downcase($::os['architecture'])]
  # $combine_subscriptions = union($subscriptions, $extra_subscriptions)
  # $runtime_assets = union(['sensu/sensu-ruby-runtime', "sensu-plugins/sensu-plugins-${title}"])
  # notice(" See the runtime array ${runtime}")
  $title_array = split($title, '-')

  sensu_check { "${title}-${trusted['certname']}":
    ensure        => $ensure,
    command       => $command,
    provider      => $provider,
    subscriptions => ["entity:${trusted['certname']}"],
    # custom      => $custom,
    # handlers    => $handler,
    interval      => $interval + seeded_rand($interval_rand_max, $title),
    # occurrences => $occurrences,
    # refresh     => $refresh,
    namespace     => $namespace,
    runtime_assets  => ['sensu/sensu-ruby-runtime', "sensu-plugins/sensu-plugins-${$title_array[0]}-${$title_array[1]}"],
    notify        => Service['sensu-agent'],
    require       => Class['::sensu_configuration::assets::base']
  }

}
