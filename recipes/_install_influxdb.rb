

if node[:moni][:influxdb][:version]
  version = node[:moni][:influxdb][:version]
else
  version = "latest"
end

path = "http://s3.amazonaws.com/influxdb/influxdb_#{version}_amd64.deb"

bash "install influxdb package" do
  cwd "/tmp"
  code <<-EOH
    wget #{path}
    dpkg -i influxdb_#{version}_amd64.deb
    EOH
  not_if "which influxdb"
end
