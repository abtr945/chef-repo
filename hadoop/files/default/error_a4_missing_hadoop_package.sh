# Error A-4: 'missing_hadoop_package'

# Description: remove the downloaded Hadoop package file (simulate scenario where package is missing or corrupted)

# Injection point: inside Step 5 - 'install_hadoop' - using recipe '5_install_hadoop_error_a4'

# Influence: will most likely break Chef script at Step 5 - 'install_hadoop'
#            since the step cannot extract the package

rm -f /tmp/*.tar.gz
