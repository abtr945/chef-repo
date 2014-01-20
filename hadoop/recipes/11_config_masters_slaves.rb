# Recipe 'config_masters_slaves'

# Step 11: configure Hadoop masters and slaves files


# Log the start
log "start_11" do
  message "<AN_TRAN> STEP 11: configure Hadoop masters and slaves starting ...."
  level :info
end

# Get the list of node names for master and slaves
masters = {}
slaves = {}

node[:opsworks][:layers][:hadoop][:instances].each do |instance_name, instance|
  if (instance_name =~ /master*/) != nil
    masters[instance[:private_ip]] = instance_name
  else
    slaves[instance[:private_ip]] = instance_name
  end
end

# Write to file from template
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

# Log the completion
log "complete_11" do
  message "<AN_TRAN> STEP 11: configure Hadoop masters and slaves completed successfully"
  level :info
end
