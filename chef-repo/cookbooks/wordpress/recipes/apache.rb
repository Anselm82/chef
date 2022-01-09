

  
case node['platform']
  when 'ubuntu'


    apt_update 'Update the apt cache daily' do
      frequency 86400
      action :periodic
    end

    package 'apache2'
    package 'php'
    package 'php-mysql'

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


  when 'centos'

    package 'httpd'

     
    package 'epel-release'
    package 'yum-utils' 

     execute 'install remi repo' do
      command 'sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm'
      action :run
     end
     
     execute 'enable remi remo' do
      command 'sudo yum-config-manager --enable remi-php72'
      action :run
     end

     execute 'install php' do
      command 'sudo yum install -y php'
      action :run
     end
     
     package 'php-mysql'

    service 'httpd' do
      supports :status => true
      action :nothing
    end

    remote_file "Copy service file" do 
      path "/etc/httpd/conf.d/wordpress.conf" 
      source "file:///vagrant/wordpress.conf"
    end
    

end


  

  



