directory '/srv/www/' do
    action :create
  end
  
  remote_file '/srv/www/latest.tar.gz' do
    source 'https://wordpress.org/latest.tar.gz'
    action :create
  end
    
  
  execute 'extract tar' do
    command 'tar xzvf /srv/www/latest.tar.gz'
    cwd '/srv/www/'
  end

  case node['platform']
  when 'ubuntu'

    remote_file "Copy file" do 
      path "/srv/www/wordpress/wp-config.php" 
      source "file:///vagrant/wp-config.php"
      notifies :restart, resources(:service => "apache2")
    end

    execute 'a2ensite wordpress' do
      command 'a2ensite wordpress' 
      notifies :reload, resources(:service => "apache2"), :immediate
    end

  when 'centos'

    service 'httpd' do
      supports :status => true
      action :nothing
    end

    remote_file "Copy file" do 
      path "/srv/www/wordpress/wp-config.php" 
      source "file:///vagrant/wp-config.php"
      notifies :restart, resources(:service => "httpd"), :immediate
    end



  end

  template "/vagrant/post.sql" do
    source 'post.sql'
  end
  
  execute 'configure wordpress' do
    command 'curl http://192.168.33.40/wp-admin/install.php?step=2 --data-urlencode "weblog_title=DevOps" --data-urlencode "user_name=wordpress" --data-urlencode "admin_email=wordpress@unir.net" --data-urlencode "admin_password=wordpress" --data-urlencode "admin_password2=wordpress" --data-urlencode "pw_weak=1"'
  end
  
  case node['platform']
  when 'ubuntu'
    execute "update post" do
      command "sudo mysql -u root --password='wordpress' < /vagrant/post.sql"
    end
  when 'centos'
    execute "update post" do
      command "sudo mysql -u root --password='wordpress' < /vagrant/post.sql"
    end
  end