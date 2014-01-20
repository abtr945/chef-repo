# Error A-1: 'dirname'

# Description: revert Hadoop directory name to hadoop-<version>

# Injection point: right after Step 5 - 'install_hadoop'

# Influence: will most likely break Chef script at Step 6 - 'change_hadoop_dir_owner'
#            since the step cannot find the expected directory name which is 'hadoop'

mv /usr/local/hadoop /usr/local/hadoop-1.2.1
