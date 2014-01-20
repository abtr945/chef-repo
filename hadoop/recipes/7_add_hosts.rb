# Recipe 'add_hosts'

# Step 7: Add the IP - node name mapping of master and slaves to /etc/hosts
# The name mapping will be the node name that we named when bootstrapping Chef node


# Log the start
log "start_7" do
  message "<AN_TRAN> STEP 7: Add mapping to /etc/hosts starting ...."
  level :info
end

# Gets list of names from all nodes managed by Chef Server
hosts = {}

node[:opsworks][:layers][:hadoop][:instances].each do |instance_name, instance|
  hosts[instance[:private_ip]] = instance_name
end

# Write the changes to /etc/hosts
template "/etc/hosts" do
  owner "root"
  group "root"
  source "hosts.erb"
  mode 0644
  variables(:hosts => hosts)
end

# Log the completion
log "complete_7" do
  message "<AN_TRAN> STEP 7: Add mapping to /etc/hosts completed successfully"
  level :info
end
