if node[:platform] == "centos" then
  execute "enable epel repository" do
    command "sudo yum -y install epel-release"
  end
  template "/etc/yum.repos.d/remi-php72.repo" do
    source 'php/remi-php72.repo'
  end
  execute "enable php repository" do
    command "sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/remi-php72.repo"
  end
  execute "install php" do
    command "sudo yum --enablerepo=remi-php72 install -y php php-fpm php-pdo php-pear php-mysql ghostscript php-bcmath php-curl php-json php-xml"
  end
else
  packages = ['php', 'php-mysql', 'ghostscript', 'php-bcmath', 'php-curl', 'php-imagick','php-intl','php-json', 'php-mbstring', 'php-xml', 'php-zip']
  packages.each do |p|
    package p do
      action :install
    end
  end
end