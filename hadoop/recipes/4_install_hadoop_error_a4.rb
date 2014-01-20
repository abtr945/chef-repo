# Recipe 'install_hadoop_error_a4'

# Step 4: Download the Hadoop package and extract to desired installation path,
# then change the name of the Hadoop folder (from hadoop-<version> to hadoop)

# Inject error A-4: remove the downloaded Hadoop package => cause Hadoop installation procedure to break


# Log the start
log "start_4" do
  message "<AN_TRAN> STEP 4: Install Hadoop starting ...."
  level :info
end

# Download the Hadoop package
script "download_hadoop" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  	wget #{node[:Hadoop][:Install][:url]}
  EOH
  not_if do FileTest.directory?("/tmp/hadoop-#{node[:Hadoop][:Install][:version]}") || FileTest.directory?(node[:Hadoop][:Install][:installPath]) end
end

# Inject error A-4
log "error_a4" do
  message "<AN_TRAN> INJECT ERROR: A4 - Hadoop software package is missing or corrupted"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_a4_missing_hadoop_package.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end


# Extract the package
script "extract_hadoop" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
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
