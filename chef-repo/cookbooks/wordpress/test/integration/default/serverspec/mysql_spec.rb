control 'Mysql Service' do
  impact 1
  desc 'Mysql is running from chef'
  case os[:family]
  when 'debian', 'suse'
    describe service('mysqld') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  else
    describe service('mysqld') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  end
end
  
control 'Listening on 3306' do
  impact 1
  desc 'Mysql should be listening on port 3306'
  describe ping('mysql://192.168.33.40:3306') do
    its('body') { should cmp /Apache/ }
  end
end

control 'mysql_database' do
  impact 1.0
  title 'test creation and removal of databases'
  sql = mysql_session('wordpress', 'wordpress')
  describe sql.query('SHOW DATABASES') do
    its(:stdout) { should match(/wordpress/) }
  end
end

control 'mysql_user' do
  impact 1.0
  title 'Check user is pressent'
  sql = mysql_session('wordpress', 'wordpress')
  describe sql.query('SELECT User, Host FROM mysql.user') do
    its(:stdout) { should match(/wordpress/) }
    its(:stdout) { should match(/localhost/) }
  end
end