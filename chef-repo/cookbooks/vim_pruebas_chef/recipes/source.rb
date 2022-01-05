# La instalación a partir del código fuente de vim también sería sencilla ya que, a parte de instalar las dependencias básicas necesarias, lo único que se debe hacer en la receta es descargar la versión deseada del código fuente, y ejecutar el comando make.

cache_path = Chef::Config['file_cache_path'] 
source_version = node['vim']['source']['version']

apt_update "update_apt_cache"

node['vim']['source']['dependencies'].each do |dependency|  
    package dependency do
        action :install 
    end
end

remote_file "#{cache_path}/vim-#{source_version}.tar.bz2" do 
    source "http://ftp.vim.org/pub/vim/unix/vim-#{source_version}.tar.bz2" 
    checksum node['vim']['source']['checksum']
    notifies :run, "bash[install_vim]", :immediately
end

bash "install_vim" do
    cwd cache_path 
    code <<-EOH
mkdir vim-#{source_version}
tar -jxf vim-#{source_version}.tar.bz2 -C vim-#{source_version} --strip-components 1
(cd vim-#{source_version}/  && ./configure #{node['vim']['source']['configuration']} && make && make install)
EOH
    action :nothing 
end
