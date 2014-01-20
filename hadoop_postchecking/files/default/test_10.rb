require 'minitest/autorun'

class TestHadoop < MiniTest::Unit::TestCase
  
  #override random test run ordering
  i_suck_and_my_tests_are_order_dependent!
  
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
  
  # Test cases after Step 9
  def test_hadoop_namenode
    file = File.open("/usr/local/hadoop/conf/core-site.xml")
    output = file.read
    file.close

    output.delete("\n")
    assert_match /<name>fs\.default\.name<\/name>\s*<value>.*master:[0-9]+<\/value>/, output, "Test 9.1 failed: the Hadoop namenode setting in core-site.xml is incorrect"
  end
  
  def test_hadoop_jobtracker
    file = File.open("/usr/local/hadoop/conf/mapred-site.xml")
    output = file.read
    file.close

    output.delete("\n")
    assert_match /<name>mapred\.job\.tracker<\/name>\s*<value>.*master:[0-9]+<\/value>/, output, "Test 9.2 failed: the Hadoop jobtracker setting in mapred-site.xml is incorrect"
  end
  
  def test_hadoop_dfs_replication
    file = File.open("/usr/local/hadoop/conf/hdfs-site.xml")
    output = file.read
    file.close

    output.delete("\n")
    tmp = output[/<name>dfs\.replication<\/name>\s*<value>([0-9]+)<\/value>/]
    tmp = $1
    assert_equal ARGV[0].to_i - 1, tmp, "Test 9.3 failed: the Hadoop dfs.replication setting in hdfs-site.xml is incorrect"
  end
  
  # Test cases after Step 10
  def test_hadoop_masters
     masters_count = 0
     File.readlines("/usr/local/hadoop/conf/masters").each do |li|
        if (li[/^\s*master[0-9]*\s*$/]) then
           masters_count = masters_count + 1
        end
     end
     
     assert masters_count > 0, "Test 10.1 failed: conf/masters file not properly populated"
  end
  
  def test_hadoop_slaves
     slaves_count = 0
     File.readlines("/usr/local/hadoop/conf/slaves").each do |li|
        if (li[/^\s*slave[0-9]*\s*$/]) then
           slaves_count = slaves_count + 1
        end
     end
     
     assert slaves_count > 0, "Test 10.2 failed: conf/slaves file not properly populated"
  end
end
