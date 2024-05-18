class profile::applications::common::rabbitmq(
  $user,
  $vhost,
  $cluster_enabled,
  $cluster_nodes,
  $erlang_cookie,
  $management_ssl,
  $package_name               = 'rabbitmq-server',
  $package_ensure             = '3.8.11-1',
  $home_dir                   = undef,
  $cluster_partition_handling = 'ignore',
  $erlang_version             = undef,
) {

  class { '::profile::applications::common::erlang':
    version => $erlang_version,
  }

  # # Install the Erlang Solutions apt key; Alternative way https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
  # wget https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
  # sudo apt-key add erlang_solutions.asc

  # # 'focal' is the latest available but an empty 'impish' directory exists and will probably be ready soon
  # sudo echo 'deb https://packages.erlang-solutions.com/ubuntu focal contrib' | sudo tee /etc/apt/sources.list.d/erlang-solutions.list
  # sudo apt update
  # sudo apt install esl-erlang elixir
  # apt-get install esl-erlang=1:24.0-1  1:22.2.7+dfsg-1ubuntu0.2
  # apt-get install erlang-base=1:24.0-1

  class { '::rabbitmq':
    package_name               => $package_name,
    package_ensure             => $package_ensure,
    config_cluster             => $cluster_enabled,
    cluster_nodes              => $cluster_nodes,
    cluster_node_type          => 'disc',
    erlang_cookie              => $erlang_cookie,
    wipe_db_on_cookie_change   => true,
    delete_guest_user          => true,
    repos_ensure               => true,
    rabbitmq_home              => $home_dir,
    environment_variables      => {
      'RABBITMQ_USE_LONGNAME' => true,
    },
    cluster_partition_handling => $cluster_partition_handling,
    management_ssl             => $management_ssl,
    # require                    => Class['::profile::applications::common::erlang'],
  }

  rabbitmq_vhost { $vhost:
    ensure => present,
  }

  rabbitmq_user { $user['name']:
    password => $user['password'],
    admin    => $user['admin'],
  }

  rabbitmq_user_permissions { "${user['name']}@${vhost}":
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  # class { '::profile::configurations::sensu::checks::host::rabbitmq':
  #   rabbitmq_vhost    => $vhost,
  #   rabbitmq_username => $user['name'],
  #   rabbitmq_password => $user['password'],
  # }

  # class { '::profile::configurations::sensu::metrics::rabbitmq':
  #   username => $user['name'],
  #   password => $user['password'],
  # }

}
