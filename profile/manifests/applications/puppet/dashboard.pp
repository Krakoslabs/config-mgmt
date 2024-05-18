class profile::applications::puppet::dashboard(
  $puppet_db_server = 'localhost',
  $puppet_db_listen_port = 8082,
  $listen_port = 443,
  $secret_key = 'a1526c5a6aba0fa0a8fcc541c92fff7d53af750cb086306d332ac8c041f3bb2f',
  $puppet_db_ssl_verify = 'false'
){

  file { '/etc/puppetboard':
    ensure => directory,
  }
  file { '/etc/puppetboard/key.pem':
    ensure => file,
    mode   => '0644',
    source => "/etc/puppetlabs/puppet/ssl/private_keys/${facts['networking']['fqdn']}.pem",
  }
  file { '/etc/puppetboard/cert.pem':
    ensure => file,
    mode   => '0644',
    source => "/etc/puppetlabs/puppet/ssl/certs/${facts['networking']['fqdn']}.pem",
  }

  include docker

  ## Github ref: https://github.com/voxpupuli/puppetboard
  docker::image { 'ghcr.io/voxpupuli/puppetboard': }

  docker::run { 'puppetboard':
    image   => 'ghcr.io/voxpupuli/puppetboard',
    volumes => ['/etc/puppetboard:/etc/puppetboard:ro'],
    env     => [
      "PUPPETDB_HOST=${puppet_db_server}", # this must be the certname or DNS_ALT_NAME of the PuppetDB host
      "PUPPETDB_PORT=${puppet_db_listen_port}",
      'PUPPETBOARD_PORT=443',
      'ENABLE_CATALOG=true',
      "PUPPETDB_SSL_VERIFY=${puppet_db_ssl_verify}",
      'PUPPETDB_KEY=/etc/puppetboard/key.pem',
      'PUPPETDB_CERT=/etc/puppetboard/cert.pem',
      "SECRET_KEY=${secret_key}",
      'DEFAULT_ENVIRONMENT=*',
    ],
    net     => 'host',
  }
}
