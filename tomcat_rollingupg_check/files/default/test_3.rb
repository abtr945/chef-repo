require 'minitest/autorun'

class TestTomcat < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
  end

  # Test cases after Step 3 - install Apache
  def test_service_apache_running
     output = `sudo service apache2 status`
     assert_match /Apache2 is running/, output, "Test 3.1 failed: Apache service is not running"
  end
  
  def test_service_tomcat_running
     output = `sudo service tomcat7 status`
     assert_match /Tomcat servlet engine is running/, output, "Test 3.2 failed: Tomcat service is not running"
  end
  
end
