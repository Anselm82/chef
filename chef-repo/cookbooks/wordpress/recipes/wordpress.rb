remote_file "#{Chef::Config[:file_cache_path]}/latest.tar.gz" do
  source "http://wordpress.org/latest.tar.gz"
  mode "0644"
end

directory "#{node['apache']['document_root']}/wordpress" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
  recursive true
end

execute "untar wordpress" do
  cwd "#{node['apache']['document_root']}/wordpress"
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/latest.tar.gz"
end

template "#{node['apache']['document_root']}/wordpress/wp-config.php" do
  source 'wordpress/wp-config.php'
end

execute "change owner and permissions" do
  command "sudo chown www-data: -R #{node['apache']['document_root']}"
  notifies :restart, resources(:service => "apache2")
end

template "#{Chef::Config[:file_cache_path]}/post.sql" do
  source 'wordpress/post.sql'
end

execute 'configure wordpress' do
  command "curl http://#{node["apache"]["ip"]}:#{node["apache"]["port"]}/wp-admin/install.php?step=2 --data-urlencode \"weblog_title=#{node['wordpress']['title']}\" --data-urlencode \"user_name=#{node['wordpress']['username']}\" --data-urlencode \"admin_email=#{node['wordpress']['email']}\" --data-urlencode \"admin_password=#{node['wordpress']['password']}\" --data-urlencode \"admin_password2=#{node['wordpress']['password']}\" --data-urlencode \"pw_weak=1\" && sudo mysql < #{Chef::Config[:file_cache_path]}/post.sql"
  #notifies :run, resources(:execute => "update post"), :delayed
end

#execute "update post" do
 # command "sudo mysql < #{Chef::Config[:file_cache_path]}/post.sql"
  #action :nothing
  #notifies :restart, resources(:service => "apache2")
#end