require 'minitest/autorun'

class TestTomcat < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
  end

  # Test cases after Step 2
  def test_tomcat_catalina_base_exist
     assert Dir.exists?("/etc/tomcat6"), "Test 2.1 failed: Tomcat CATALINA_BASE directory does not exist"
  end
  
  def test_tomcat_webapp_base_exist
     assert Dir.exists?("/var/lib/tomcat6"), "Test 2.2 failed: Tomcat webapps base directory do not exist"
  end
  
  def test_tomcat_lib_directory_exist
     assert Dir.exists?("/usr/share/tomcat6"), "Test 2.3 failed: Tomcat library directory do not exist"
  end
  
end
