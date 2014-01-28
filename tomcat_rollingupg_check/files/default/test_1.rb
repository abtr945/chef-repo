require 'minitest/autorun'

class TestTomcat < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
  end

  # Test cases after Step 1 - install new Tomcat package (version 7) 
  def test_tomcat6_catalina_base_exist
  	 refute Dir.exists?("/etc/tomcat6"), "Test 1.1 failed: Older Tomcat6 CATALINA_BASE directory still present"
  end
  
  def test_tomcat6_webapp_base_exist
     refute Dir.exists?("/var/lib/tomcat6"), "Test 1.2 failed: Older Tomcat6 webapps base directory still present"
  end
  
  def test_tomcat6_lib_directory_exist
     refute Dir.exists?("/usr/share/tomcat6"), "Test 1.3 failed: Older Tomcat6 library directory still present"
  end
  
  def test_tomcat7_catalina_base_exist
     assert Dir.exists?("/etc/tomcat7"), "Test 1.4 failed: Tomcat7 CATALINA_BASE directory does not exist"
  end
  
  def test_tomcat7_webapp_base_exist
     assert Dir.exists?("/var/lib/tomcat7"), "Test 1.5 failed: Tomcat7 webapps base directory do not exist"
  end
  
  def test_tomcat7_lib_directory_exist
     assert Dir.exists?("/usr/share/tomcat7"), "Test 1.6 failed: Tomcat7 library directory do not exist"
  end
  
end
