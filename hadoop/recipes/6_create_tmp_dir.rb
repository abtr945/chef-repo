# Recipe 'create_tmp_dir'

# Step 6 - create temporary directory for Hadoop files and set proper permission


# Log the start
log "start_6" do
  message "<AN_TRAN> STEP 6: create Hadoop temporary directory starting ...."
  level :info
end

# Create directory
directory node[:Hadoop][:Core][:hadoopTmpDir] do
  owner "hduser"
  group "hadoop"
  mode "0770"
  recursive true
  action :create
end

# Log the completion
log "complete_6" do
  message "<AN_TRAN> STEP 6: create Hadoop temporary directory completed successfully"
  level :info
end