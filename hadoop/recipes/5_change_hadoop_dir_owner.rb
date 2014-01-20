# Recipe 'change_hadoop_dir_owner'

# Step 5: change the Hadoop installation directory owner to the Hadoop user - hduser:hadoop


# Log the start
log "start_5" do
  message "<AN_TRAN> STEP 5: Change Hadoop directory owner starting ...."
  level :info
end

# Change the Hadoop directory owner to hduser:hadoop
execute "change_dir_owner" do
  user "root"
  command "chown -R hduser:hadoop #{node[:Hadoop][:Install][:installPath]}"
  only_if do FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end

# Log the completion
log "complete_5" do
  message "<AN_TRAN> STEP 5: Change Hadoop directory owner completed successfully"
  level :info
end
