# Error C-3: 'skip_add_hosts'

# Description: skip the insertion of nodename - IP address mapping into /etc/hosts file

# Injection point: right after Step 3 - 'add_hosts'

# Influence: will most likely break Chef script at Step 4 - 'ssh_login'
#            since the step need to SSH to the nodes using their node names


sudo sed -i 's/^.*master$//' /etc/hosts
sudo sed -i 's/^.*slave{0-9}+$//' /etc/hosts
