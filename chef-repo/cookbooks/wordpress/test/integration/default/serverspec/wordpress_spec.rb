control 'First post is displayed' do
  impact 1
  desc 'Wordpress first post is displayed'
  describe http('localhost') do
    its('status') { should eq 200 }
    its('body') { should cmp /This is the default welcome page/ }
  end
end