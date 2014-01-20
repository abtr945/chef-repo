# Recipe 'create_hadoop_user'

# Step 2: Create a dedicated user and group for using Hadoop
# Name of group: "hadoop"
# Name of user: "hduser"
# Password of user: "password"


# Log the start
log "start_2" do
  message "<AN_TRAN> STEP 2: Create dedicated Hadoop user starting ...."
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
log "complete_2" do
  message "<AN_TRAN> STEP 2: Create dedicated Hadoop user completed successfully"
  level :info
end
