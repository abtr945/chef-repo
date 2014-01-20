# Error A-3: 'hadoop_owner'

# Description: revert Hadoop directory owner to 'root'

# Injection point: right after Step 6 - 'change_hadoop_owner'

# Influence: will most likely break Chef script at Step 8 - 'config_env'
#            since the step don't have root permission to modify files inside Hadoop directory

sudo chown root:root /usr/local/hadoop
