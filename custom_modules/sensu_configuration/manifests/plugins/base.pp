class sensu_configuration::plugins::base {

  case downcase($::osfamily) {

    'windows': {
      ensure_resource('package', 'sensu-plugins-windows',
        {
          ensure   => '0.0.10',
          provider => sensuclassic_gem,
        }
      )
    }

    default: {
      ensure_resource('Class', 'sensu::plugins', {
        plugins => {
          'cpu-checks'     => { 'version' => 'latest' },
          # 'disk-checks'    => { 'version' => '3.0.0' }, # Dependency with ruby >= 2.5
          'load-checks'    => { 'version' => 'latest' },
          'memory-checks'  => { 'version' => 'latest' },
          'network-checks' => { 'version' => 'latest' },
          'process-checks' => { 'version' => 'latest' },
        },
      })

    }

  }

}
