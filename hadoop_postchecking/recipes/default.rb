#
# Cookbook Name:: hadoop_postchecking
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/tmp/run_test.sh" do
  source "run_test.sh"
end

cookbook_file "/tmp/test_2.rb" do
  source "test_2.rb"
end

cookbook_file "/tmp/test_4.rb" do
  source "test_4.rb"
end

cookbook_file "/tmp/test_6.rb" do
  source "test_6.rb"
end

cookbook_file "/tmp/test_8.rb" do
  source "test_8.rb"
end

cookbook_file "/tmp/test_10.rb" do
  source "test_10.rb"
end
