service_name = 'mysql'

if node[:platform] == "centos" then
  service_name = 'mysqld'
  template "/etc/yum.repos.d/mysql-community.repo" do
    source 'mysql/mysql-community.repo'
  end
  execute "install mysql" do
    command "sudo yum --enablerepo=mysql56-community install -y mysql-community-server"
  end
else 
  package 'mysql-server'
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
  template "#{Chef::Config[:file_cache_path]}/init_wordpress_db_ubuntu.sql" do
    source 'mysql/init_wordpress_db_ubuntu.sql'
  end
  execute "init mysql database" do
    command "sudo mysql < #{Chef::Config[:file_cache_path]}/init_wordpress_db_ubuntu.sql"
    notifies :restart, resources(:service => service_name), :immediate
  end
else
  execute "update port" do
    command "echo \"port = #{node['mysql']['port']}\" >> /etc/my.cnf.d/mysql-server.conf"
    notifies :restart, resources(:service => service_name), :immediate
  end
  template "#{Chef::Config[:file_cache_path]}/init_wordpress_db_centos.sql" do
    source 'mysql/init_wordpress_db_centos.sql'
  end
  execute "init database" do
    command "sudo mysql < #{Chef::Config[:file_cache_path]}/init_wordpress_db_centos.sql"
    notifies :restart, resources(:service => service_name), :immediate
  end
end