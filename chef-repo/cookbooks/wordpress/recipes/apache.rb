package 'Install Apache' do
  case node[:platform]
  when 'redhat', 'centos'
    package_name 'httpd'
  when 'ubuntu', 'debian'
    package_name 'apache2'
  end
end

package 'php apache library' do
  case node[:platform]
  when 'redhat', 'centos'
    package_name 'httpd'
  when 'ubuntu', 'debian'
    package_name 'libapache2-mod-php'
  end
end 

service 'apache2' do
  supports :status => true
  action :nothing
end
  
file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end
  
template '/etc/apache2/sites-available/wordpress.conf' do
  source 'apache/wordpress.conf'
end
  
link '/etc/apache2/sites-enabled/wordpress.conf' do
  to '/etc/apache2/sites-available/wordpress.conf'
  notifies :restart, resources(:service => "apache2")
end

link '/etc/apache2/mods-enabled/rewrite.load' do
  to '/etc/apache2/mods-available/rewrite.load'
  notifies :restart, resources(:service => "apache2")
end