class puppet_server::puppet_db(
  $working_directory,
  $service_name,
  $puppet_termini_version,
  $enabled,
  $server,
  $port = hiera('puppet::dashboard::puppetdb::ssl_port', 8082),
) {

  assert_private()

  $puppet_db_conf_path = "${working_directory}/puppetdb.conf"
  $routes_yaml_path    = "${working_directory}/routes.yaml"

  package { 'puppetdb-termini':
    ensure => $puppet_termini_version,
  }

  $ensure = $enabled ? {
    true    => present,
    default => absent,
  }

  file { $puppet_db_conf_path:
    ensure  => $ensure,
    content => template('puppet_server/puppetdb.conf.erb'),
    notify  => Service[$service_name],
    require => Package['puppetdb-termini'],
  }

  file { $routes_yaml_path:
    ensure  => $ensure,
    content => file('puppet_server/routes.yaml'),
    notify  => Service[$service_name],
    require => File[$puppet_db_conf_path],
  }

}
