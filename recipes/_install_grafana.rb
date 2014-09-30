
# depends on nginx

bash "download grafana" do
  code <<-EOH
    mkdir /opt/site
    wget http://grafanarel.s3.amazonaws.com/grafana-1.8.0.tar.gz
    tar zxvf grafana-1.8.0.tar.gz
    mv grafana-1.8.0 /opt/site/
    EOH
end
