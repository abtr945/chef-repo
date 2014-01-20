# Error B-2: 'no_java_runtime'

# Description: uninstall Java Runtime on the host machine

# Injection point: right after Step 2 - 'install_java'

# Influence: will NOT break Chef installation sequence
#            can only be detected when starting Hadoop (java not found)

apt-cache search java | awk '{print($1)}' | grep -E -e '^(ia32-)?(sun|oracle)-java' -e '^openjdk-' -e '^icedtea' -e '^(default|gcj)-j(re|dk)' -e '^gcj-(.*)-j(re|dk)' -e 'java-common' | xargs sudo apt-get -y remove
sudo apt-get -y autoremove