apt_update 'Update the apt cache daily' do
  frequency 86400
  action :periodic
end

if node[:platform] == "ubuntu"
  include_recipe '::apache'
  include_recipe '::mysql'
  include_recipe '::php'
  include_recipe '::wordpress'
elsif node[:platform] == "centos"
  include_recipe '::httpd'
  include_recipe '::mysql'
  #include_recipe '::php'
  #include_recipe '::wordpress'
end
