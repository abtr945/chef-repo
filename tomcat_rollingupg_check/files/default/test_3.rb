require 'minitest/autorun'

class TestTomcat < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
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
