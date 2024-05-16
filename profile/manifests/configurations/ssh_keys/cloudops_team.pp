class profile::configurations::ssh_keys::cloudops_team {

  linux_security::ssh_keys { 'cloudops_team':
    users => hiera('users::cloudops_team', {}),
  }

}
