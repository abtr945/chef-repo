# Recipe 'error_b1': inject error B-1

log "error_b1" do
  message "<AN_TRAN> INJECT ERROR: B1 - revert Hadoop temporary directory owner to 'root' owner"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_b1_tmpfolder.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
