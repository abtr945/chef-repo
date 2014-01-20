# Recipe 'config_site'

# Step 10: configure Hadoop *-site.xml files (core-site, mapred-site, hdfs-site)


# Log the start
log "start_10" do
  message "<AN_TRAN> STEP 10: configure Hadoop *-site.xml starting ...."
  level :info
end

# Get number of slave nodes
dfsReplication = 0

node[:opsworks][:layers][:hadoop][:instances].each do |instance_name, instance|
  if (instance_name =~ /slave*/) != nil
    dfsReplication = dfsReplication + 1
  end
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
  variables({
    :dfsReplication => dfsReplication
  })
end

template "#{node[:Hadoop][:Install][:installPath]}/conf/mapred-site.xml" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "mapred-site.xml.erb"
end

# Log the completion
log "complete_10" do
  message "<AN_TRAN> STEP 10: configure Hadoop *-site.xml completed successfully"
  level :info
end