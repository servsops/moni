
# if have multiple hosts in the role, config other hosts to use the first host as seed server

seed_server = nil
current_ip = nil

if Dir.exists?("/home/vagrant")
  current_ip = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first
else
  current_ip = node.cloud.private_ips[0]
end

if node[:moni][:discovery] && node[:hostname] != "#{node[:moni][:discovery]}1"
  nodes = search(:node, "role:#{node[:moni][:discovery]}")

  # vagrant (chef-zero) or opsworks
  if Dir.exists?("/home/vagrant")
    ip = nodes[0][:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first
  else
    ip = nodes[0].cloud.private_ips[0]
  end
  seed_server = "#{ip}:8090"
  log "[notice] found #{nodes.join(' ')} when search #{node[:moni][:discovery]}, using #{seed_server}"
end

template "/opt/influxdb/shared/config.toml" do
  mode 0644
  owner "root"
  group "root"
  variables({ :seed_server => seed_server, :hostname => current_ip })
  source "config.toml.erb"
  notifies :restart, "service[influxdb]", :delayed
end

service "influxdb" do
  supports :restart => true, :status => true, :reload => true
  action [ :enable, :start ]
end



# delete a server out of the cluster (23 is the server id)
# curl -X DELETE 'http://localhost:8086/cluster/servers/23?u=root&p=root'
