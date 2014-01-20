# Recipe 'error_c2': inject error C-2

log "error_c2" do
  message "<AN_TRAN> INJECT ERROR: C2 - disable clear-text password authentication for SSH on the host machine"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_c2_disable_ssh_password_auth.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
