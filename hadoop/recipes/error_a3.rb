# Recipe 'error_a3': inject error A-3

log "error_a3" do
  message "<AN_TRAN> INJECT ERROR: A3 - revert Hadoop directory owner from dedicated user back to 'root' owner"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_a3_hadoop_owner.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
