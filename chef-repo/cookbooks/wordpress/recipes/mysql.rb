package 'mysql-server'

execute 'extract_some_tar' do
  command 'sudo mysql -u root < /vagrant/init.sql'
end


