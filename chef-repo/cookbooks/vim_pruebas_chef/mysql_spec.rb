require 'spec_helper'

describe 'Mysql Service' do
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

describe 'mysql_database' do
  sql = mysql_session('wordpress', 'wordpress')
  describe sql.query('SHOW DATABASES') do
    its(:stdout) { should match(/wordpress/) }
  end
end

describe 'mysql_user' do
  sql = mysql_session('wordpress', 'wordpress')
  describe sql.query('SELECT User, Host FROM mysql.user') do
    its(:stdout) { should match(/wordpress/) }
    its(:stdout) { should match(/localhost/) }
  end
end