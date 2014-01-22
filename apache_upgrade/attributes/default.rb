case node['platform']
when 'redhat', 'centos', 'scientific', 'fedora', 'suse', 'amazon', 'oracle'
  default['apache']['package']     = 'httpd'
when 'debian', 'ubuntu'
  default['apache']['package']     = 'apache2'
when 'arch'
  default['apache']['package']     = 'apache'
when 'freebsd'
  default['apache']['package']     = 'apache22'
end

case node['platform_family']
when 'rhel', 'fedora', 'suse'
  default['apache']['service']     = 'httpd'
when 'debian'
  default['apache']['service']     = 'apache2'
when 'arch'
  default['apache']['service']     = 'httpd'
when 'freebsd'
  default['apache']['service']     = 'apache22'
end