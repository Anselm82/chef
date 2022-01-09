# InSpec test for recipe default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

family = os[:family]

if family == "debian" then
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

describe service('mysql') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
  
describe port(80) do
  it { should be_listening }
end

describe port(3306) do
  it { should be_listening }
end

sql = mysql_session('wordpress', 'D3v@psT00ls')
describe sql.query('SHOW DATABASES') do
  its(:stdout) { should match(/wordpress/) }
end

sql = mysql_session('wordpress', 'D3v@psT00ls')
describe sql.query('USE wordpress; SHOW TABLES;') do
  its(:stdout) { should match(/wp_posts/) }
end

describe command('curl http://localhost') do
  its('stdout') { should match /.*<h1 class="site-title">DevOps<\/h1>.*/ } 
end

describe http('192.168.33.40') do
  its('status') { should eq 200 }
  its('body') { should match(/Juan José Hernández/) }
  its('body') { should match(/Adrián Pérez/) }
  its('body') { should match(/Beatriz Serrano/) }
end