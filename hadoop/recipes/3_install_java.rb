# Recipe 'install_java'

# Step 3: Install Java which is required to run Hadoop


# Log the start
log "start_3" do
  message "<AN_TRAN> STEP 3: Install Java runtime starting ...."
  level :info
end

# Install apt and java using community cookbooks
include_recipe 'apt'
include_recipe 'java'

# Log the completion
log "complete_3" do
  message "<AN_TRAN> STEP 3: Install Java runtime completed successfully"
  level :info
end
