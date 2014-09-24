

path = "http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb"

bash "install influxdb package" do
  cwd "/tmp"
  code <<-EOH
    wget #{path}
    dpkg -i influxdb_latest_amd64.deb
    EOH
  not_if "which influxdb"
end
