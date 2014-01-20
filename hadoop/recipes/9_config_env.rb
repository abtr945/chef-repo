# Recipe: 'config_env'

# Step 9: configure Hadoop environment in hadoop_env.sh


# Log the start
log "start_9" do
  message "<AN_TRAN> STEP 9: configure hadoop-env.sh starting ...."
  level :info
end

# Write the configuration from template
template "#{node[:Hadoop][:Install][:installPath]}/conf/hadoop-env.sh" do
  owner "hduser"
  group "hadoop"
  mode "0644"
  source "hadoop-env.sh.erb"
end

# Log the completion
log "complete_9" do
  message "<AN_TRAN> STEP 9: configure hadoop-env.sh completed successfully"
  level :info
end
