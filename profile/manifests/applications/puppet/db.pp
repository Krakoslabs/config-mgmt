class profile::applications::puppet::db(
  $version     = '7.18.0-1focal',
  $listen_port = 8081,
  $ssl_listen_port = 8082,
  $listen_address = '0.0.0.0',
  $manage_firewall = false,
  $disable_ssl = false,
){
  $jvm_initial_memory   = floor($::memorysize_mb * 0.25)
  $jvm_assigned_memory  = floor($::memorysize_mb * 0.5)

  class { '::puppetdb::globals':
    version => $version,
  }

  class { '::puppetdb':
    listen_address  => $listen_address,
    listen_port     => $listen_port,
    ssl_listen_port => $ssl_listen_port,
    manage_firewall => $manage_firewall,
    disable_ssl     => $disable_ssl,
    java_args       => {
      '-Xmx' => "${jvm_assigned_memory}m",
      '-Xms' => "${jvm_initial_memory}m",
    },
  }

  $folder = "/etc/puppetlabs/code/environments/${::environment}"
  file { $folder:
    ensure  => 'directory',
    require => Class['::puppetdb'],
  }
}
