require 'minitest/autorun'

class TestTomcat < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
  end

  # Test cases after Step 2
  def test_catalina_home_existed
     assert Dir.exists? ("/etc/tomcat6") && Dir.exists? ("/usr/share/tomcat6") && Dir.exists? ("/var/lib/tomcat6"), "Test 2.1 failed: Tomcat executable and/or library folder do not exist"
  end
  
end
