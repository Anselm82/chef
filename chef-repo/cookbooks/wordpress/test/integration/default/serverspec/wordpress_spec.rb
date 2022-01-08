control 'First post is displayed' do
  impact 1
  desc 'Wordpress first post is displayed'
  describe http('192.168.33.40') do
    its('status') { should eq 200 }
    its('body') { should cmp /This is the default welcome page/ }
  end
end