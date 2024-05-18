class role::infrastructure::puppet::dashboard {

  include ::profile::configurations::base::linux::base
  include ::profile::configurations::puppet::db
  include ::profile::configurations::puppet::dashboard

}
