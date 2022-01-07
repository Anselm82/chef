directory '/srv/www/' do
    action :create
  end
  
  remote_file '/srv/www/latest.tar.gz' do
    source 'https://wordpress.org/latest.tar.gz'
    action :create
  end
    
  
  execute 'extract_some_tar' do
    command 'tar xzvf /srv/www/latest.tar.gz'
    cwd '/srv/www/'
  end

  remote_file "Copy service file" do 
    path "/srv/www/wordpress/wp-config.php" 
    source "file:///vagrant/wp-config.php"
    notifies :restart, resources(:service => "apache2")
  end

  execute 'a2ensite wordpress' do
    command 'a2ensite wordpress' 
    notifies :restart, resources(:service => "apache2")
  end

  template "/vagrant/post.sql" do
    source 'post.sql'
  end
  
  chef_sleep 'name' do
    seconds      5
    action       :sleep 
  end

  execute 'configure wordpress' do
    command 'curl http://192.168.33.40/wp-admin/install.php?step=2 --data-urlencode "weblog_title=DevOps" --data-urlencode "user_name=wordpress" --data-urlencode "admin_email=wordpress@unir.net" --data-urlencode "admin_password=wordpress" --data-urlencode "admin_password2=wordpress" --data-urlencode "pw_weak=1"'
  end
  
  execute "update post" do
    command "sudo mysql < /vagrant/post.sql"
  end