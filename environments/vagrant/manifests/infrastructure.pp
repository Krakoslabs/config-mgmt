node 'puppetserver.vagrant.local' {
  include ::role::infrastructure::puppet::server
}

node 'ubuntu20-1.vagrant.local' {
  include ::role::infrastructure::puppet::dashboard
  # include ::role::infrastructure::monitoring::sensu::grafana
}

node 'ubuntu20-2.vagrant.local' {
  include ::role::infrastructure::monitoring::sensu::server
}

node 'ubuntu20-3.vagrant.local' {
  include ::role::infrastructure::monitoring::sensu::grafana
}

node 'ubuntu20-4.vagrant.local' {
  # Try puppet forge module on me.......
}
