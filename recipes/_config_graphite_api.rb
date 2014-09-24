

path = node[:moni][:graphite][:path]
directory path do
  mode 0644
  owner "root"
  group "root"
  action :create
end

graphite = {}
graphite[:index] = "#{path}/index"

# use the first influxdb or a load balancer ?
graphite[:influxdb_host] = node[:moni][:graphite][:influxdb_path]

template "/etc/graphite-api.yaml" do
  mode 0644
  owner "root"
  group "root"
  variables({ :graphite => graphite })
  source "graphite-api.yaml.erb"
  notifies :restart, "service[graphite-api]", :delayed
end

# control script

template "/etc/init/graphite-api.conf" do
  mode 0644
  owner "root"
  group "root"
  source "upstart-graphite-api.conf.erb"
end

service "graphite-api" do
  supports :restart => true, :status => true
  provider Chef::Provider::Service::Upstart
  action [ :enable,  :start ]
end
