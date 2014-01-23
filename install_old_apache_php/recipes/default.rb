#
# Cookbook Name:: install_old_apache_php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Only support Amazon Linux AMI

# Modify Yum repo to an older repo
template "/etc/yum.conf" do
  source "yum.conf.erb"
  owner "root"
  group "root"
  variables({
     :release_ver => "2011.09"
  })
end

# Install Apache 2.2.22 and PHP 5.3.10
package "apache2" do
  package_name "httpd"
  action :install
end

package "php" do
  package_name "php"
  action :install
end

# Enable (at boot) and start apache2 service
service "apache2" do
  service_name "httpd"
  action [:enable, :start]
end

# Reset Yum repo to latest repo
template "/etc/yum.conf" do
  source "yum.conf.erb"
  owner "root"
  group "root"
  variables({
     :release_ver => "latest"
  })
end
