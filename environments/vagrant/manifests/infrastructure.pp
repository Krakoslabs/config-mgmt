node 'puppetserver.vagrant.local' {
  include ::role::infrastructure::puppet::server
}

node 'centos7-1.vagrant.local' {
  include ::role::infrastructure::monitoring::sensu::server
}

node 'centos7-2.vagrant.local' {
  include ::role::infrastructure::monitoring::sensu::grafana
}

node 'centos7-3.vagrant.local' {
  include ::role::infrastructure::puppet::dashboard
}

node 'centos7-4.vagrant.local' {
  include ::role::infrastructure::bind::server
  include ::role::infrastructure::consul::server
  #include ::profile::configurations::base::linux::base
}
