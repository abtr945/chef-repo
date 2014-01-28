# Copyright 2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not
# use this file except in compliance with the License. A copy of the License is
# located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions
# and limitations under the License.

include_recipe 'tomcat::install'

log "complete_step_1" do
  message "<AN_TRAN> STEP 1: deploy new Tomcat package (version 7) completed successfully"
  level :info
end

include_recipe 'tomcat::service'

service 'tomcat' do
  action :enable
end

# for EBS-backed instances we rely on autofs
bash '(re-)start autofs earlier' do
  user 'root'
  code <<-EOC
    service autofs restart
  EOC
  notifies :restart, resources(:service => 'tomcat')
end

include_recipe 'tomcat::container_config'

log "complete_step_2" do
  message "<AN_TRAN> STEP 2: configure Tomcat environment and container parameters completed successfully"
  level :info
end

include_recipe 'apache2'
include_recipe 'tomcat::apache_tomcat_bind'

log "complete_step_3" do
  message "<AN_TRAN> STEP 3: deploy Apache package, configure Tomcat to bind with Apache server completed successfully"
  level :info
end
