class puppet_server::install {

  assert_private()

  $jvm_initial_memory_raw  = floor($::memorysize_mb * 0.25)
  $jvm_assigned_memory_raw = floor($::memorysize_mb * 0.5)

  $jvm_initial_memory  = "${jvm_initial_memory_raw}M"
  $jvm_assigned_memory = "${jvm_assigned_memory_raw}M"

  # class { '::puppet_server::repository': }

  class { '::puppetserver':
      java_args => "-Xms${jvm_initial_memory} -Xmx${jvm_assigned_memory} -XX:MaxPermSize=256m"
    },
  }

  service { 'puppet':
    ensure => true,
    enable => true,
  }

}
