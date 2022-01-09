describe 'wordpress::default' do
  platform 'ubuntu'

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

  context 'execute update post wordpress' do
    it 'execute update post' do
      expect(chef_run).to run_execute('update post').with(
        :command => "sudo mysql < #{Chef::Config[:file_cache_path]}/post.sql"
      )
    end
  end

  context 'execute untar wordpress' do
    it 'execute untar wordpress' do
      expect(chef_run).to run_execute('untar wordpress').with(
        :cwd => "/var/www/wordpress", #falla meter variable #{document_root}/wordpress
        :command => "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/latest.tar.gz"
      )
    end
  end

end

describe 'wordpress::default' do
  platform 'centos'
  
  
end