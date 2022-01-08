packages = ['php', 'php-mysql', 'ghostscript', 'php-bcmath', 'php-curl', 'php-imagick','php-intl','php-json', 'php-mbstring', 'php-xml', 'php-zip']
if node[:platform] == "centos" then
  packages = ['php']
end

packages.each do |p|
  package p do
    action :install
  end
end

