#
# Cookbook Name:: hadoop-1.2.1
# Recipe:: default
#
# Copyright 2013, An Binh TRAN
#
# All rights reserved - Do Not Redistribute
#

# Step 0 - enable clear-text password authentication for SSH login
# Required for copying ssh keys from master to slaves
# Need to be done at node BOOTSTRAP


# Log the start
log "Step 0: Enable password authentication for SSH login starting ...." do
  level :info
end

# Enable password SSH login in config file
template "/etc/ssh/sshd_config" do
  mode "0644"
  source "sshd_config.erb"
end

# Restart the SSH service
service "ssh" do
  supports :restart => true, :reload => true
  action :enable
  subscribes :reload, "template[/etc/ssh/sshd_config]", :immediately
end

# Log the completion
log "Step 0: Enable password authentication for SSH login completed successfully" do
  level :info
end
 

# Step 1: Install Java which is required to run Hadoop


# Log the start
log "Step 1: Install Java runtime starting ...." do
  level :info
end

# Install apt and java using community cookbooks
include_recipe 'apt'
include_recipe 'java'

# Log the completion
log "Step 1: Install Java runtime completed successfully" do
  level :info
end


# Step 2: Create a dedicated user and group for using Hadoop
# Name of group: "hadoop"
# Name of user: "hduser"
# Password of user: "password"


# Log the start
log "Step 2: Create dedicated Hadoop user starting ...." do
  level :info
end

script "create_user" do
  interpreter "bash"
  user "root"
  code <<-EOH
  sudo addgroup hadoop
  sudo useradd --gid hadoop -m hduser
  echo -e "password\npassword" | (sudo passwd hduser)
  EOH
end

# Log the completion
log "Step 2: Create dedicated Hadoop user completed successfully" do
  level :info
end


hosts = {}
localhost = nil

search(:node, "name:*", %w(ipaddress fqdn)) do |n|
  hosts[n["ipaddress"]] = n
end

template "/etc/hosts" do
  owner "root"
  group "root"
  source "hosts.erb"
  mode 0644
  variables(:hosts => hosts)
end

if node.name == "master"

  # Install sshpass
  package "sshpass"
  
  # Create empty RSA password
  execute "ssh-keygen" do
    command "sudo -u hduser ssh-keygen -q -t rsa -N '' -f /home/hduser/.ssh/id_rsa"
    creates "/home/hduser/.ssh/id_rsa"
    action :run
  end

  # Copy public key to all masters and slaves; if key doesn't exist in authorized_keys, append it to this file
  hosts.keys.sort.each do |ip|
    execute "copy_ssh_keys" do
      command <<-EOH
        sudo -u hduser sshpass -p "password" scp -o StrictHostKeyChecking=no /home/hduser/.ssh/id_rsa.pub hduser@#{hosts[ip].name}:/tmp
        sudo -u hduser sshpass -p "password" ssh -o StrictHostKeyChecking=no hduser@#{hosts[ip].name} "(mkdir -p .ssh; touch .ssh/authorized_keys; grep #{node[:fqdn]} .ssh/authorized_keys > /dev/null || cat /tmp/id_rsa.pub >> .ssh/authorized_keys; rm /tmp/id_rsa.pub)"
      EOH
    end
  end
  
else
  log "This is not a master node - no need to execute SSH config" do
    level :info
  end
end

script "install_hadoop" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  	wget #{node[:Hadoop][:Install][:url]}
  	tar -zxf hadoop-#{node[:Hadoop][:Install][:version]}.tar.gz
  	rm -f hadoop-#{node[:Hadoop][:Install][:version]}.tar.gz
  EOH
  not_if do FileTest.directory?("/tmp/hadoop-#{node[:Hadoop][:Install][:version]}") || FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end

execute "rename_hadoop_folder" do
  user "root"
  command "mv /tmp/hadoop-#{node[:Hadoop][:Install][:version]} #{node[:Hadoop][:Install][:installPath]}"
  not_if do !FileTest.directory?("/tmp/hadoop-#{node[:Hadoop][:Install][:version]}") || FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end

execute "change_dir_owner" do
  user "root"
  command "chown -R hduser:hadoop #{node[:Hadoop][:Install][:installPath]}"
  only_if do FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end


# Error Injection
cookbook_file "/tmp/error.sh" do
  source "errorb1_dirname.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end


template "#{node[:Hadoop][:Install][:installPath]}/conf/core-site.xml" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "core-site.xml.erb"
end

template "#{node[:Hadoop][:Install][:installPath]}/conf/hdfs-site.xml" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "hdfs-site.xml.erb"
end

template "#{node[:Hadoop][:Install][:installPath]}/conf/mapred-site.xml" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "mapred-site.xml.erb"
end

template "#{node[:Hadoop][:Install][:installPath]}/conf/hadoop-env.sh" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "hadoop-env.sh.erb"
end

masters = {}
slaves = {}
localhost = nil

search(:node, "name:master*", %w(ipaddress fqdn)) do |n|
  masters[n["ipaddress"]] = n
end

search(:node, "name:slave*", %w(ipaddress fqdn)) do |n|
  slaves[n["ipaddress"]] = n
end

template "#{node[:Hadoop][:Install][:installPath]}/conf/masters" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "masters.erb"
  variables(:masters => masters)
end

template "#{node[:Hadoop][:Install][:installPath]}/conf/slaves" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "slaves.erb"
  variables(:slaves => slaves)
end

directory node[:Hadoop][:Core][:hadoopTmpDir] do
  owner "hduser"
  group "hadoop"
  mode "0770"
  recursive true
  action :create
end
