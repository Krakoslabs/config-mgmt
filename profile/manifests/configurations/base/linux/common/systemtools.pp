class profile::configurations::base::linux::common::systemtools (
  $linux_tools = hiera('server_config::linux::systemtools', undef),
) {
  ensure_resource('package', $linux_tools,{ ensure => present,})
}
