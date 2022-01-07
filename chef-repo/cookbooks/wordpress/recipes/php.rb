['php', 'php-mysql', 'ghostscript', 'php-bcmath', 'php-curl', 'php-imagick','php-intl','php-json', 'php-mbstring', 'php-xml', 'php-zip'].each do |p|
  package p do
    action :install
  end
end

