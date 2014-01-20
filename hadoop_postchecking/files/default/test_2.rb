require 'minitest/autorun'

class TestHadoop < MiniTest::Unit::TestCase
  
  # tests are order dependent
  def self.test_order
    :alpha
  end

  # Test cases after Step 1
  def test_hadoop_user_created
     output = `egrep -i "^hduser" /etc/passwd`
     refute_equal "", output, "Test 1.1 failed: Dedicated user for hadoop not yet created"
  end
  
  def test_hadoop_group_created
     output = `egrep -i "^hadoop" /etc/group`
     refute_equal "", output, "Test 1.2 failed: Dedicated group for hadoop not yet created"
  end
  
  # Test cases after Step 2
  def test_java_install
     output = `which java`
     refute_equal "", output, "Test 2.1 failed: Java runtime not yet installed"
  end   

end
