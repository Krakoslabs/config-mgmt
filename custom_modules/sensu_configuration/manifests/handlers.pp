class sensu_configuration::handlers {

  include ::sensu_configuration::handlers::metrics
  # include ::sensu_configuration::handlers::opsgenie
  # include ::sensu_configuration::handlers::slack
  # include ::sensu_configuration::handlers::teams
  # include ::sensu_configuration::handlers::influxdb_handoff

}
