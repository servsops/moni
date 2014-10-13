#default[:moni][:discovery] = "influxdb"

# safe to use in development environment
# default[:moni][:influxdb][:version] = "latest"

default[:moni][:influxdb] = {
  :version => "0.8.1"
}
default[:moni][:graphite] = {
  :path => "/opt/graphite",
  :influxdb_path => "127.0.0.1"
}
