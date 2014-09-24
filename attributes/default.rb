default[:moni][:discovery] = "influxdb"
default[:moni][:graphite] = {
  :path => "/opt/graphite",
  :influxdb_path => "127.0.0.1"
}
