apt_update 'Update the apt cache daily' do
    frequency 86400
    action :periodic
  end
  
  package 'apache2'
  
  service 'apache2' do
    supports :status => true
    action :nothing
  end
  
  file '/etc/apache2/sites-enabled/000-default.conf' do
    action :delete
  end

  remote_file "Copy service file" do 
    path "/etc/apache2/sites-available/wordpress.conf" 
    source "file:///vagrant/wordpress.conf"
  end
  
  link '/etc/apache2/sites-enabled/wordpress.conf' do
    to '/etc/apache2/sites-available/wordpress.conf'
    notifies :restart, resources(:service => "apache2")
  end
  

include_recipe '::wordpress'
include_recipe '::facts'

  