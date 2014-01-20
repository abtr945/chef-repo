# Recipe 'error_c3': inject error C-3

log "error_c3" do
  message "<AN_TRAN> INJECT ERROR: C3 - do not add the IP-hostname mappings of the master and slave nodes to /etc/hosts"
  level :info
end

cookbook_file "/tmp/error.sh" do
  source "error_c3_skip_add_hosts.sh"
end
script "run_error_script" do
  interpreter "bash"
  user "root"
  code "sh /tmp/error.sh"
end
