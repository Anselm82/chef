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
  end

  # Configure the MySQL client.
mysql_client 'default' do
    action :create
  end
  mysql_service 'default' do
    bind_address '0.0.0.0'
    port '3306'
    data_dir '/data'
    initial_root_password "password123"
    action [:create, :start]
  end