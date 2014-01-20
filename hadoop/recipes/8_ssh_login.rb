# Recipe 'ssh_login'

# Step 8: enable passwordless SSH login between master node and all slave nodes
# by copying the SSH public key of master node to all nodes in cluster

# This recipe will only execute on master node


if node[:opsworks][:instance][:hostname] == "master"

  # Log the start
  log "start_8" do
    message "<AN_TRAN> STEP 8: Enable passwordless SSH login from master node starting ...."
    level :info
  end

  # Install sshpass to automatically provide password
  package "sshpass"

  # Create empty RSA password
  execute "ssh-keygen" do
    command "sudo -u hduser ssh-keygen -q -t rsa -N '' -f /home/hduser/.ssh/id_rsa"
    creates "/home/hduser/.ssh/id_rsa"
    action :run
  end

  # Gets list of names from all nodes managed by Chef Server
  hosts = {}

  node[:opsworks][:layers][:hadoop][:instances].each do |instance_name, instance|
    hosts[instance[:private_ip]] = instance_name
  end

  # Copy public key to all masters and slaves; if key doesn't exist in authorized_keys, append it to this file
  hosts.keys.sort.each do |ip|
    execute "copy_ssh_keys_#{ip}" do
      command <<-EOH
        sudo -u hduser sshpass -p "password" scp -o StrictHostKeyChecking=no /home/hduser/.ssh/id_rsa.pub hduser@#{hosts[ip].name}:/tmp
        sudo -u hduser sshpass -p "password" ssh -o StrictHostKeyChecking=no hduser@#{hosts[ip].name} "(mkdir -p .ssh; touch .ssh/authorized_keys; grep #{node[:fqdn]} .ssh/authorized_keys > /dev/null || cat /tmp/id_rsa.pub >> .ssh/authorized_keys; rm /tmp/id_rsa.pub)"
      EOH
    end
  end
  
  # Log the completion
  log "complete_8" do
    message "<AN_TRAN> STEP 8: Enable passwordless SSH login from master node completed successfully"
    level :info
  end

else

  log "not_master" do
    message "<AN_TRAN> STEP 8: Enable passwordless SSH from master - This is not a master node, do nothing"
    level :info
  end
  
end
