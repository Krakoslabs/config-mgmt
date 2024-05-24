class role::infrastructure::monitoring::sensu::grafana {

  ensure_resource('Class', '::profile::configurations::base::linux::base', { })
  include ::profile::configurations::databases::metrics::influxdb
  # include ::profile::configurations::databases::mysql::grafana
  # include ::profile::configurations::grafana::sensu

  # Send data to influxb
  # while true; do r=$(( $RANDOM % 1000000 )); curl -i -XPOST 'http://centos7-2.vagrant.local:8086/write?db=sensu_metrics' --data-binary "testgrafana,host=centos7-2.vagrant.local value=`echo $r`"; sleep 5;done

  # Interval variable: 5s,10s,30s,1m,5m,15m,30m,1h,2h,1d
  # machine variable: query --> show measurements
  # sensu.(centos[0-9]+-[0-9]+).*

  # \w+.\w+.(\w+)-load-balancer

  # Query on graph: /^sensu.$machine./

  # echo '{
  #   "handlers": ["teams"],
  #   "occurrences": 5,
  #   "interval": 65,
  #   "name": "test_marcos_currency_converter",
  #   "output": "data acquisition is not consuming from Service Bus, please check it.",
  #   "type": "check",
  #   "status": 1
  # }' | nc -w1 172.16.0.41 3030

}
