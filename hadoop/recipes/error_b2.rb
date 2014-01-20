# Recipe 'error_b2': inject error B-2

log "error_b2" do
  message "<AN_TRAN> INJECT ERROR: B2 - remove the Java Runtime on the host machine"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_b2_no_java_runtime.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
