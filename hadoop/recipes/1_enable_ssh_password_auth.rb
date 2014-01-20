# Recipe 'enable_ssh_password_auth'

# Step 1 - enable clear-text password authentication for SSH login
# Required for copying ssh keys from master to slaves


# Log the start
log "start_1" do
  message "<AN_TRAN> STEP 1: Enable password authentication for SSH login starting ...."
  level :info
end

# Enable password SSH login in config file
template "/etc/ssh/sshd_config" do
  mode "0644"
  source "sshd_config.erb"
end

# Restart SSH service
service "ssh" do
  supports :restart => true, :reload => true
  action :enable
  subscribes :reload, "template[/etc/ssh/sshd_config]", :immediately
end

# Log the completion
log "complete_1" do
  message "<AN_TRAN> STEP 1: Enable password authentication for SSH login completed successfully"
  level :info
end
