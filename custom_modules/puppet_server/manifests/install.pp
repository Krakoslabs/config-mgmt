class puppet_server::install {

  assert_private()

  $jvm_initial_memory_raw  = floor($::memorysize_mb * 0.25)
  $jvm_assigned_memory_raw = floor($::memorysize_mb * 0.5)

  $jvm_initial_memory  = "${jvm_initial_memory_raw}M"
  $jvm_assigned_memory = "${jvm_assigned_memory_raw}M"

  file_line { 'puppetserver-memory':
    path => '/etc/default/puppetserver',  
    line => "JAVA_ARGS=\"-Xms${jvm_initial_memory} -Xmx${jvm_assigned_memory} -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger\"",
    match   => "^JAVA_ARGS=.*$",
    notify => Service['puppetserver']
  }

  service { 'puppetserver':
    ensure => true,
    enable => true,
  }

}
