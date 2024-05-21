class profile::configurations::base::linux::base (
  $sensu          = hiera('sensu::agent::enabled', false),
  $puppetagent    = hiera('puppet::agent::enabled', false),
){

  include ::profile::configurations::base::default_directory
  include ::profile::configurations::base::linux::common::locales
  include ::profile::configurations::base::linux::common::systemtools

  include ::profile::configurations::base::linux::security

  if $puppetagent {
    include ::profile::configurations::puppet::agent
  }

  if $sensu {
    ensure_resource('Class', '::profile::configurations::sensu::agent', { })
    include ::profile::configurations::sensu::checks::host::sensu_agent
  }

}
