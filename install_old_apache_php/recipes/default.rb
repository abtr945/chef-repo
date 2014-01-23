#
# Cookbook Name:: install_old_apache_php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Only support Amazon Linux AMI


# Install Apache 2.2.2 and PHP 5.2.13
cookbook_file "/tmp/httpd-2.2.2-1.x86_64.rpm" do
  source "httpd-2.2.2-1.x86_64.rpm"
end

cookbook_file "/tmp/php-5.2.13-3rt.x86_64.rpm" do
  source "php-5.2.13-3rt.x86_64.rpm"
end

execute "install_apache" do
  cwd "/tmp"
  user "root"
  group "root"
  command "yum localinstall httpd-2.2.2-1.x86_64.rpm"
end

execute "install_php" do
  cwd "/tmp"
  user "root"
  group "root"
  command "yum localinstall php-5.2.13-3rt.x86_64.rpm"
end

# Enable (at boot) and start apache2 service
service "apache2" do
  service_name "httpd"
  action [:enable, :start]
end
