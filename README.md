# config-mgmt
config-mgmt with puppet


List all the certificates on puppetserver
`/opt/puppetlabs/bin/puppetserver ca list --all`

Remove an existing certificate
`/opt/puppetlabs/bin/puppetserver ca clean --certname ubuntu20-1.vagrant.local`




## Grafana variable to extract hostnames:

```
import "influxdata/influxdb/v1"
v1.tagValues(
    bucket: v.bucket,
    tag: "sensu_entity_name",
    predicate: (r) => true,
    start: -1d
)
```


## Query for extract specific metric from dashboard panel
```
from(bucket: "sensu")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["sensu_entity_name"] == "${host}")
  |> filter(fn: (r) => r["_field"] =~ /${host}.memory.*/)
```

```
from(bucket: "sensu")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["sensu_entity_name"] == "${host}")
  |> filter(fn: (r) => r["_field"] =~ /${host}.memory.percent.(available|free$)/)
```
