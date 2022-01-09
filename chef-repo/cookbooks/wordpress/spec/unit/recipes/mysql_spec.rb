describe 'wordpress::default' do
  platform 'ubuntu'

  context 'install mysql server with default properties' do
    it 'installs mysql server packages' do
      expect(chef_run).to install_package('mysql-server')
    end
  end

  context 'copy mysql conf template' do
    it 'create file mysql conf' do  
      expect(chef_run).to create_template('/etc/mysql/mysql.conf.d/mysql.cnf').with(
        :source => 'mysql/mysql.cnf.erb'
      )
    end
  end

  context 'copy mysql conf template 2' do
    it 'create file mysql conf 2' do
      expect(chef_run).to create_template('/etc/mysql/mysql.conf.d/mysqld.cnf').with(
        :source => 'mysql/mysqld.cnf.erb'
      )
    end
  end

  context 'copy db init sql template' do
    it 'create db init mysql sql template' do  
      expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/init_wordpress_db.sql").with(
        :source => 'mysql/init_wordpress_db.sql'
      )
    end
  end

  context 'execute init mysql database' do
    it 'execute init mysql database mysql' do
      expect(chef_run).to run_execute('init mysql database').with(
        :command => "sudo mysql < #{Chef::Config[:file_cache_path]}/init_wordpress_db.sql"
      )
    end
  end

end

describe 'wordpress::default' do
  platform 'centos'
  
  context 'install mysql server with default properties centos' do
    it 'installs mysql server packages centos' do
      expect(chef_run).to install_package('mysql-community-server')
    end
  end

  context 'copy db init sql template centos' do
    it 'create db init mysql sql template centos' do  
      expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/init_wordpress_db.sql").with(
        :source => 'mysql/init_wordpress_db.sql'
      )
    end
  end
  
end