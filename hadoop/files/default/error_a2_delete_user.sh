# Error A-2: 'delete_user'

# Description: remove the dedicated Hadoop user and group

# Injection point: right after Step 1 - 'create_hadoop_user'

# Influence: will most likely break Chef script at Step 6 - 'change_hadoop_dir_owner'
#            since the step cannot find the user and group

userdel -r hduser
groupdel hadoop
