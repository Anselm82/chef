service_name = 'apache2'
user_and_group = "www-data"
document_root = node['apache']['document_root']
db_service_name = "mysql"
case node[:platform]
when 'redhat', 'centos'
  service_name = 'httpd'
  user_and_group = "apache"
  document_root = '/var/www'
  db_service_name = "mysqld"
end

remote_file "#{Chef::Config[:file_cache_path]}/latest.tar.gz" do
  source "http://wordpress.org/latest.tar.gz"
  mode "0644"
end

directory "#{document_root}/wordpress" do
  owner user_and_group
  group user_and_group
  mode "0755"
  action :create
  recursive true
end

execute "untar wordpress" do
  cwd "#{document_root}/wordpress"
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/latest.tar.gz"
end

template "#{document_root}/wordpress/wp-config.php" do
  source 'wordpress/wp-config.php'
  notifies :restart, resources(:service => service_name), :immediate
  notifies :restart, resources(:service => db_service_name), :immediate
end

execute "change owner and permissions" do
  command "sudo chown #{user_and_group}: -R #{document_root}"
  notifies :restart, resources(:service => service_name), :immediate
  notifies :restart, resources(:service => db_service_name), :immediate
end

template "#{Chef::Config[:file_cache_path]}/post.sql" do
  source 'wordpress/post.sql'
end

execute 'configure wordpress' do
  command 'curl http://127.0.0.1/wp-admin/install.php?step=2 --data-urlencode "weblog_title=DevOps" --data-urlencode "user_name=wordpress" --data-urlencode "admin_email=wordpress@unir.net" --data-urlencode "admin_password=wordpress" --data-urlencode "admin_password2=wordpress" --data-urlencode "pw_weak=1"'
end

execute "update post" do
  command "sudo mysql -u #{node['mysql']['user']} -p\"#{node['mysql']['password']}\" < #{Chef::Config[:file_cache_path]}/post.sql"
end