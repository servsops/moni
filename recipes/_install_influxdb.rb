

path = "http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb"

version = node[:moni][:influxdb][:version]

path = "http://s3.amazonaws.com/influxdb/influxdb_#{version}_amd64.deb"

bash "install influxdb package" do
  cwd "/tmp"
  code <<-EOH
    wget #{path}
    dpkg -i influxdb_#{version}_amd64.deb
    EOH
  not_if "which influxdb"
end
