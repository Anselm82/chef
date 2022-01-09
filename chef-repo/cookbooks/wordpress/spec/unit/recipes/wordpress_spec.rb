describe 'wordpress::default' do
  platform 'ubuntu'

  context 'remote file wordpress' do
    it 'remote file wordpress' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/latest.tar.gz").with(
        :source => 'http://wordpress.org/latest.tar.gz',
        :mode => "0644"
      )
    end
  end

  context 'create directory wordpress' do
    it 'creates directory wordpress' do
      expect(chef_run).to create_directory('/var/www/wordpress').with(
      owner: "www-data",
      group: "www-data",
      recursive: true, 
      mode: "0755"
      )
    end
    end

  context 'execute untar wordpress' do
    it 'execute untar wordpress' do
      expect(chef_run).to run_execute('untar wordpress').with(
        :cwd => "/var/www/wordpress",
        :command => "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/latest.tar.gz"
      )
    end
  end

  context 'copia wp-config.php template' do
    it 'create wp-config.php wordpress template' do
      expect(chef_run).to create_template("/var/www/wordpress/wp-config.php").with(
        :source => 'wordpress/wp-config.php'
      )
    end
  end

  context 'copia post.sql template' do
    it 'create copia post.sql wordpress template' do
      expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/post.sql").with(
        :source => 'wordpress/post.sql'
      )
    end
  end

  context 'execute configuration blog wordpress' do
    it 'execute configure wordpress' do
      expect(chef_run).to run_execute('configure wordpress').with(
        :command => 'curl http://127.0.0.1/wp-admin/install.php?step=2 --data-urlencode "weblog_title=DevOps" --data-urlencode "user_name=wordpress" --data-urlencode "admin_email=wordpress@unir.net" --data-urlencode "admin_password=wordpress" --data-urlencode "admin_password2=wordpress" --data-urlencode "pw_weak=1"'
      )
    end
  end

end

describe 'wordpress::default' do
  platform 'centos'
  
  context 'remote file wordpress centos' do
    it 'remote file wordpress centos' do
      expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/latest.tar.gz").with(
        :source => 'http://wordpress.org/latest.tar.gz',
        :mode => "0644"
      )
    end
  end

  context 'copia post.sql template centos' do
    it 'create copia post.sql wordpress template centos' do
      expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/post.sql").with(
        :source => 'wordpress/post.sql'
      )
    end
  end
  
end