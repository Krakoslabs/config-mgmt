define sensu_configuration::metric(
  $command,
  $ensure            = 'present',
  $provider          = 'sensu_api',
  $handlers          = hiera('sensu::default_metric_handlers'),
  $interval          = hiera('sensu::default_interval'),
  $interval_rand_max = hiera('sensu::default_interval_rand_max'),
  $occurrences       = hiera('sensu::default_occurrences'),
  $refresh           = hiera('sensu::default_refresh'),
  $namespace         = hiera('sensu::agent::namespace')
) {

  ensure_resource('Class', 'sensu_configuration::plugins::base', { })

  # sensuclassic::check { $title:
  #   ensure      => $ensure,
  #   command     => $command,
  #   type        => 'metric',
  #   handlers    => $handlers,
  #   interval    => $interval + seeded_rand($interval_rand_max, $title),
  #   occurrences => $occurrences,
  #   refresh     => $refresh,
  #   require     => Class['sensu_configuration::plugins::base'],
  # }

    sensu_check { "${title}-${trusted['certname']}":
      ensure        => $ensure,
      command       => $command,
      provider      => $provider,
      subscriptions => ["entity:${trusted['certname']}"],
      output_metric_format   => 'influxdb_line',
      output_metric_handlers => ['influxdb'],
      interval      => $interval + seeded_rand($interval_rand_max, $title),
      publish       => true,
      # occurrences => $occurrences,
      # refresh     => $refresh,
      namespace     => $namespace,
      notify        => Service['sensu-agent'],
      require       => Class['sensu_configuration::plugins::base'],
  }

}
