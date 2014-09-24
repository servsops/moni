
"build-essential python-dev libffi-dev libcairo2-dev python-pip".split(" ").each do |pkg|
  package pkg
end

bash "install graphite-api from pip" do
  code <<-EOH
    pip install https://github.com/Dieterbe/graphite-api/tarball/support-templates2
    pip install gunicorn graphite-influxdb Flask-Cache statsd raven blinker
    EOH
  not_if "which gunicorn"
end

template "/etc/init/graphite-api.conf" do
  mode 0644
  owner "root"
  group "root"
  source "upstart-graphite-api.conf.erb"
end

directory "/opt/graphite" do
  mode 0644
  owner "root"
  group "root"
  action :create
end

graphite = {}
graphite[:index] = "/opt/graphite/index"
graphite[:influxdb_host] = "192.168.89.221" 

template "/etc/graphite-api.yaml" do
  mode 0644
  owner "root"
  group "root"
  variables({ :graphite => graphite })
  source "graphite-api.yaml.erb"
end
