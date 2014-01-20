# Recipe 'error_a1': inject error A-1

log "error_a1" do
  message "<AN_TRAN> INJECT ERROR: A1 - revert Hadoop directory name from 'hadoop' back to 'hadoop-<version>'"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_a1_dirname.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
