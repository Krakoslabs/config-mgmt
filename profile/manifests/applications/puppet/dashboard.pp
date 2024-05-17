class profile::applications::puppet::dashboard {

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

  docker::image { 'ghcr.io/voxpupuli/puppetboard': }

  docker::run { 'puppetboard':
    image   => 'ghcr.io/voxpupuli/puppetboard',
    volumes => ['/etc/puppetboard:/etc/puppetboard:ro'],
    env     => [
      'PUPPETDB_HOST=ubuntu20-1.vagrant.local', # this must be the certname or DNS_ALT_NAME of the PuppetDB host
      'PUPPETDB_PORT=8082',
      'PUPPETBOARD_PORT=443',
      'ENABLE_CATALOG=true',
      'PUPPETDB_SSL_VERIFY=false',
      'PUPPETDB_KEY=/etc/puppetboard/key.pem',
      'PUPPETDB_CERT=/etc/puppetboard/cert.pem',
      'SECRET_KEY=puppetdb',
      'DEFAULT_ENVIRONMENT=*',
    ],
    net     => 'host',
  }
}
