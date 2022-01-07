control 'Apache Service' do
  impact 1
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

control 'Listening on 80' do
  impact 1
  desc 'Apache should be listening on port 80'
  describe http('http://127.0.0.1:80') do
    its('body') { should cmp /Apache/ }
  end
end
