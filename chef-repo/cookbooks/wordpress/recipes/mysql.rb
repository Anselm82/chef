
  
case node['platform']
when 'ubuntu'

  package 'mysql-server'

  execute 'extract_some_tar' do
    command 'sudo mysql -u root < /vagrant/init_ubuntu.sql'
  end


when 'centos'

 
  execute 'mysql-community-repo' do
    command 'sudo yum -y localinstall http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm'
    action :run
   end

   execute 'enable remi remo' do
    command 'sudo yum-config-manager --enable mysql56-community'
    action :run
   end

   execute 'enable remi remo' do
    command 'sudo yum install -y mysql-community-server'
    action :run
   end

 # execute 'enable remi remo' do
 #  command 'sudo systemctl set-environment MYSQLD_OPTS="--skip-grant-tables"'
 #  action :run
 # end
   
  service 'mysqld' do
    supports :status => true
    action [:enable, :restart]
  end

  execute 'extract_some_tar' do
    command "sudo mysql -u root < /vagrant/init.sql"
    #command "PASS=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $(NF)}' | tr -d $'\n') ; sudo mysql -u root --password=\'$PASS\' --connect-expired-password < /vagrant/init.sql"
  end

  
  #bash 'init database' do
  #  code <<-EOH
  #    password=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $(NF)}' | tr -d $'\n')
  #    sudo mysql -u root -p $password < /vagrant/init.sql
  #  EOH
  #end



 #execute 'enable remi remo' do
 #  command 'sudo systemctl unset-environment MYSQLD_OPTS'
 #  action :run
 # end

   service 'mysqld' do
    supports :status => true
    action [:enable, :restart]
  end



end