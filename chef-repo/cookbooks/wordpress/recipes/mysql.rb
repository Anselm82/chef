package 'mysql-server'
  
service 'mysql' do
  supports :status => true
  action :nothing
end
  
template '/etc/mysql/mysql.conf.d/mysql.cnf' do
  source 'mysql/mysql.cnf.erb'
  notifies :restart, resources(:service => "mysql")
end

template '/etc/mysql/mysql.conf.d/mysqld.cnf' do
  source 'mysql/mysqld.cnf.erb'
  notifies :restart, resources(:service => "mysql")
end

template "#{Chef::Config[:file_cache_path]}/init_wordpress_db.sql" do
  source 'mysql/init_wordpress_db.sql'
end

execute "init mysql database" do
  command "sudo mysql < #{Chef::Config[:file_cache_path]}/init_wordpress_db.sql"
  notifies :restart, resources(:service => "mysql")
end