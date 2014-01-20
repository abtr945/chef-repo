# Error C-2: 'disable_ssh_password_auth'

# Description: not enabling clear-text password SSH login in all nodes

# Injection point: right after Step 0 - 'enable_password_ssh_auth'

# Influence: will most likely break Chef script at Step 4 - 'ssh_login' at MASTER NODE
#            since the MASTER NODE need to SSH to the nodes using password authentication

sudo sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication = no/' /etc/ssh/sshd_config
sudo service ssh restart
