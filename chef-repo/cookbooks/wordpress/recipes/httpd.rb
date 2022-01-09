package 'httpd'

service 'httpd' do
  supports :status => true
  action :enable
end

directory "/etc/httpd/sites-available" do
  action :create
end

directory "/etc/httpd/sites-enabled" do
  action :create
end

execute "update config" do
  command "echo \"IncludeOptional sites-enabled/*.conf\" >> /etc/httpd/conf/httpd.conf"
  notifies :restart, resources(:service => "httpd")
end

file "/etc/httpd/sites-enabled/000-default.conf" do
  action :delete
end
  
template "/etc/httpd/sites-available/wordpress.conf" do
  source 'apache/wordpress.conf'
end
  
link "/etc/httpd/sites-enabled/wordpress.conf" do
  to "/etc/httpd/sites-available/wordpress.conf"
  notifies :restart, resources(:service => "httpd")
end