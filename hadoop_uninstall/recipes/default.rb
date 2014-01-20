#
# Cookbook Name:: hadoop_uninstall
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Delete the hadoop user
script "delete_user" do
  interpreter "bash"
  user "root"
  code <<-EOH
  sudo userdel -r hduser
  sudo groupdel hadoop
  EOH
end

# Uninstall Java
script "uninstall_java" do
  interpreter "bash"
  user "root"
  code <<-EOH
    sudo apt-get update
    apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs sudo apt-get -y remove
    sudo apt-get -y autoremove
  EOH
end

# Uninstall Hadoop
script "uninstall_hadoop" do
  interpreter "bash"
  user "root"
  code <<-EOH
  sudo rm -rf /usr/local/hadoop
  sudo rm -rf /app/hadoop
  EOH
end
