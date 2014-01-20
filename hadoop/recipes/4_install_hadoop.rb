# Recipe 'install_hadoop'

# Step 4: Download the Hadoop package and extract to desired installation path,
# then change the name of the Hadoop folder (from hadoop-<version> to hadoop)


# Log the start
log "start_4" do
  message "<AN_TRAN> STEP 4: Install Hadoop starting ...."
  level :info
end

# Download and extract the Hadoop package
script "install_hadoop" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  	wget #{node[:Hadoop][:Install][:url]}
  	tar -zxf hadoop-#{node[:Hadoop][:Install][:version]}.tar.gz
  	rm -f hadoop-#{node[:Hadoop][:Install][:version]}.tar.gz
  EOH
  not_if do FileTest.directory?("/tmp/hadoop-#{node[:Hadoop][:Install][:version]}") || FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end

# Rename the Hadoop folder
execute "rename_hadoop_folder" do
  user "root"
  command "mv /tmp/hadoop-#{node[:Hadoop][:Install][:version]} #{node[:Hadoop][:Install][:installPath]}"
  not_if do !FileTest.directory?("/tmp/hadoop-#{node[:Hadoop][:Install][:version]}") || FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end

# Log the completion
log "complete_4" do
  message "<AN_TRAN> STEP 4: Install Hadoop completed successfully"
  level :info
end