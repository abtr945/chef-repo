require 'minitest/autorun'

class TestTomcat < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
  end

  # Test cases after Step 1
  def test_tomcat_user_created
     output = `egrep -i "^tomcat" /etc/passwd`
     refute_equal "", output, "Test 1.1 failed: Dedicated user for hadoop not yet created"
  end
  
  def test_tomcat_group_created
     output = `egrep -i "^tomcat" /etc/group`
     refute_equal "", output, "Test 1.2 failed: Dedicated group for hadoop not yet created"
  end
  
  # Test cases after Step 2
  def test_catalina_home_existed
     assert Dir.exists? ("/etc/tomcat6") && Dir.exists? ("/usr/share/tomcat6") && Dir.exists? ("/var/lib/tomcat6"), "Test 2.1 failed: Tomcat executable and/or library folder do not exist"
  end
  
  # Test cases after Step 3
  def test_service_apache_running
     output = `sudo service apache2 status`
     assert_match output, /Apache2 is running/, "Test 3.1 failed: Apache service is not running"
  end
  
  def test_service_tomcat_running
     output = `sudo service tomcat6 status`
     assert_match output, /Tomcat servlet engine is running/, "Test 3.2 failed: Tomcat service is not running"
  end
  
end