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
  
end
