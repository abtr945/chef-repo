#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install apt and java using community cookbooks
include_recipe 'apt'
include_recipe 'java'

script "install_logstash" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar
  EOH
end

template "/tmp/logstash.conf" do
  mode "0644"
  source "logstash.conf.erb"
end

template "/tmp/patterns" do
  mode "0644"
  source "patterns.erb"
end

# Install ruby 1.9.3 for use with the post-condition checking
script "install_ruby" do
  interpreter "bash"
  user "root"
  code <<-EOH
  	sudo apt-get install -y ruby1.9.3
  EOH
end

# Start logstash as a background process
script "start_logstash" do
  interpreter "bash"
  user "root"
  code <<-EOH
  	sudo java -jar /tmp/logstash-1.2.1-flatjar.jar agent -f /tmp/logstash.conf &
  EOH
end
