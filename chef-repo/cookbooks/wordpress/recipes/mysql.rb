service_name = 'mysql'

if node[:platform] == "centos" then
  service_name = 'mysqld'
end

package 'Mysql Server' do 
  if node[:platform] == "centos" then
    package_name 'mysql-community-server'
  else
    package_name 'mysql-server'
  end
end

service service_name do
  supports :status => true
  action :nothing
end
  
if node[:platform] == "ubuntu" then
  template "/etc/mysql/mysql.conf.d/mysql.cnf" do
    source 'mysql/mysql.cnf.erb'
    notifies :restart, resources(:service => service_name)
  end

  template "/etc/mysql/mysql.conf.d/mysqld.cnf" do
    source 'mysql/mysqld.cnf.erb'
    notifies :restart, resources(:service => service_name)
  end
else 
  execute "update port" do
    command "echo \"port = #{node['mysql']['port']}\" >> /etc/my.cnf.d/mysql-server.conf"
    notifies :restart, resources(:service => service_name)
  end
end

template "#{Chef::Config[:file_cache_path]}/init_wordpress_db.sql" do
  source 'mysql/init_wordpress_db.sql'
end

execute "init mysql database" do
  command "sudo mysql < #{Chef::Config[:file_cache_path]}/init_wordpress_db.sql"
  notifies :restart, resources(:service => service_name)
end