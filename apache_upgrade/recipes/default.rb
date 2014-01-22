#
# Cookbook Name:: apache_upgrade
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Stop the current Apache services
service "apache2_stop" do
  service_name node['apache']['service']
  action :stop
end

# Upgrade Apache to latest version
package "apache2" do
  package_name node['apache']['package']
  version "2.4.7"
  action :upgrade
end

# Enable Apache service at boot, and start the Apache service
service "apache2_start" do
  service_name node['apache']['service']
  action [:enable, :start]
end
