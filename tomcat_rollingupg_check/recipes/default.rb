#
# Cookbook Name:: tomcat_rollingupg_check
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Install apt and java using community cookbooks
include_recipe 'apt'
include_recipe 'java'

# Install logstash
script "install_logstash" do
  interpreter "bash"
  user "root"
  cwd "#{node[:logstash][:install_path]}"
  code <<-EOH
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar
  EOH
end

# Configure logstash
template "#{node[:logstash][:install_path]}/logstash.conf" do
  mode "0644"
  owner "root"
  group "root"
  source "logstash.conf.erb"
  variables({
    :regexp      => node[:logstash][:regexp],
    :tags        => node[:logstash][:tags],
    :testnumbers => node[:logstash][:testnumbers]
  })
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
    sudo java -jar #{node[:logstash][:install_path]}/logstash-1.3.3-flatjar.jar agent -f #{node[:logstash][:install_path]}/logstash.conf &
  EOH
end

# Install the test wrapper and test cases
template "#{node[:test][:location]}/TestInterface.rb" do
  mode "0644"
  owner "root"
  group "root"
  source "TestInterface.rb.erb"
end

cookbook_file "#{node[:test][:location]}/test_1.rb" do
  source "test_1.rb"
end

cookbook_file "#{node[:test][:location]}/test_2.rb" do
  source "test_2.rb"
end

cookbook_file "#{node[:test][:location]}/test_3.rb" do
  source "test_3.rb"
end

cookbook_file "#{node[:test][:location]}/test_complete.rb" do
  source "test_complete.rb"
end
