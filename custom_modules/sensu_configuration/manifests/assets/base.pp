class sensu_configuration::assets::base (
  $namespace = hiera('sensu::agent::namespace')
){

  case downcase($::osfamily) {

    # TODO: (2024-06-01) - Implement me.....
    'windows': {
      ensure_resource('package', 'sensu-plugins-windows',
        {
          ensure   => '0.0.10',
          provider => sensuclassic_gem,
        }
      )
    }

    default: {

      $assets = {
        'sensu/sensu-ruby-runtime'                   => { ensure => 'present', version => 'latest', namespace => $namespace },
        'sensu-plugins/sensu-plugins-disk-checks'    => { ensure => 'present', version => 'latest', namespace => $namespace },
        'sensu-plugins/sensu-plugins-cpu-checks'     => { ensure => 'present', version => 'latest', namespace => $namespace },
        'sensu-plugins/sensu-plugins-load-checks'    => { ensure => 'present', version => 'latest', namespace => $namespace },
        'sensu-plugins/sensu-plugins-memory-checks'  => { ensure => 'present', version => 'latest', namespace => $namespace },
        'sensu-plugins/sensu-plugins-process-checks' => { ensure => 'present', version => 'latest', namespace => $namespace },
      }
      create_resources('sensu_bonsai_asset', $assets)

      # sensu_bonsai_asset { 'sensu/sensu-influxdb-handler':
      #     ensure    => 'present',
      #     version   => '4.0.0',
      #     namespace => $namespace
      # }
      # ensure_resource('Resources', 'sensu_bonsai_asset', $assets)
      # sensu_bonsai_asset { $assets: }

      # sensu_bonsai_asset { 'sensu/sensu-influxdb-handler':
      #   ensure    => 'present',
      #   version   => '4.0.0',
      #   namespace => $namespace
      # }
      # ensure_resource('Resource', 'sensu_bonsai_asset', $assets)
      # sensu_asset { 'sensu-ruby-runtime':
      #   ensure => 'present',
      #   builds => [
      #     {
      #       "url" => "https://assets.bonsai.sensu.io/2efc9b3e39af1d72266a74bdb4e14cf2c4dc9bd4/check-disk-usage_0.7.0_linux_amd64.tar.gz",
      #       "sha512" => "0b76e7718bcaf8843d6ece48def228a6bbbe4221442b995d66ef17b52820f82640feebceee1003f400cd35535f33a31fb4d2a98c0012aa334f4e8c4ce726f57a",
      #       "filters" => [
      #         "entity.system.os == 'linux'",
      #         "entity.system.arch == 'amd64'"
      #       ],
      #     }
      #   ]
      # }

      # ensure_resource('Class', '::sensu::plugins', {
      #   plugins => {
      #     'cpu-checks'     => { 'version' => 'latest' },
      #     # TODO: (2024-06-01) - Resolve gem dependency "ffi requires Ruby version >= 2.5."
      #     # 'disk-checks'    => { 'version' => '5.0.0' },
      #     'load-checks'    => { 'version' => 'latest' },
      #     'memory-checks'  => { 'version' => 'latest' },
      #     'network-checks' => { 'version' => 'latest' },
      #     'process-checks' => { 'version' => 'latest' },
      #   },
      # })

    }

  }

}
