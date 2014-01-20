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
  
  # Test cases after Step 3
  def test_add_hosts
     hosts_count = 0
     File.readlines("/etc/hosts").each do |li|
        if (li[/^\s*[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\s+master\s*$/]) then
           hosts_count = hosts_count + 1
        end
        if (li[/^\s*[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\s+slave[0-9]+\s*$/]) then
           hosts_count = hosts_count + 1
        end
     end
     
     assert_equal ARGV[0].to_i, hosts_count, "Test 3.1 failed: /etc/hosts not properly populated with mappings of nodes in cluster"
  end
     
  # Test cases after Step 5
  def test_hadoop_directory_exists
     assert Dir.exists?("/usr/local/hadoop"), "Test 5.1 failed: the Hadoop executable directory does not exist"
  end
  
  # Test cases after Step 6
  def test_hadoop_directory_owner
     output = `ls -ld /usr/local/hadoop | awk '{print $3 $4}'`
     assert_equal "hduserhadoop\n", output, "Test 6.1 failed: the Hadoop executable directory does not have proper access permission"
  end
  
  # Test cases after Step 7
  def test_hadoop_tmp_directory_exists
     assert Dir.exists?("/app/hadoop/tmp"), "Test 7.1 failed: the Hadoop temporary directory does not exist"
  end
  
  def test_hadoop_tmp_directory_owner
     output = `ls -ld /app/hadoop/tmp | awk '{print $3 $4}'`
     assert_equal "hduserhadoop\n", output, "Test 7.2 failed: the Hadoop temporary directory does not have proper access permission"
  end
  
end
