class profile::applications::common::erlang($version){
  class { '::erlang':
    # version => $version,
    package_name   => 'erlang-base',
    # package_ensure => '1:22.2.7+dfsg-1ubuntu0.2'
  }
}
