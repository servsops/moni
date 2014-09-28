#default[:moni][:discovery] = "influxdb"

default[:moni][:influxdb] = {
  :version => "0.8.1"
}
default[:moni][:graphite] = {
  :path => "/opt/graphite",
  :influxdb_path => "127.0.0.1"
}
