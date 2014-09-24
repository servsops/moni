# install packages

"build-essential python-dev libffi-dev libcairo2-dev python-pip".split(" ").each do |pkg|
  package pkg
end

# graphite-api gunicorn from pip

bash "install graphite-api from pip" do
  code <<-EOH
    pip install https://github.com/Dieterbe/graphite-api/tarball/support-templates2
    pip install gunicorn graphite-influxdb Flask-Cache statsd raven blinker
    EOH
  not_if "which gunicorn"
end

