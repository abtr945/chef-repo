# Recipe 'error_a2': inject error A-2

log "error_a2" do
  message "<AN_TRAN> INJECT ERROR: A2 - remove the dedicated User and Group for running Hadoop"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_a2_delete_user.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
