describe 'Apache Service' do
  desc 'Apache2 is running from chef'
  case os[:family]
  when 'debian', 'suse'
    describe service('apache2') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  else
    describe service('httpd') do
      it { should be_installed }
      it { should be_enabled }
      it { should be_running }
    end
  end
end

describe 'Listening on 80' do
  desc 'Apache should be listening on port 80'
  describe http('http://192.168.33.40:80') do
    its('body') { should cmp /Apache/ }
  end
end
