service_name = 'mysql'

if node[:platform] == "centos" then
  service_name = 'mysqld'
  template "/etc/yum.repos.d/mysql-community.repo" do
    source 'mysql/mysql-community.repo'
  end
  execute "install mysql" do
    command "sudo yum --enablerepo=mysql80-community install -y mysql-community-server"
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
  execute "init mysql database" do
    command "sudo mysql < #{Chef::Config[:file_cache_path]}/init_wordpress_db.sql"
    notifies :restart, resources(:service => service_name), :immediate
  end
else
  execute "update port" do
    command "echo \"port = #{node['mysql']['port']}\" >> /etc/my.cnf.d/mysql-server.conf"
  end
  
  template "#{Chef::Config[:file_cache_path]}/init_wordpress_db.sql" do
    source 'mysql/init_wordpress_db.sql'
  end
  bash 'init database' do
    code <<-EOH
      password=$(sudo more /var/log/mysqld.log | grep temporary | cut -c113-125)
      sudo mysql -u root -p $password < #{Chef::Config[:file_cache_path]}/init_wordpress_db.sql
    EOH
  end
  execute "unset options" do
    command "sudo systemctl unset-environment MYSQLD_OPTS"
    notifies :restart, resources(:service => service_name), :immediate
  end
end