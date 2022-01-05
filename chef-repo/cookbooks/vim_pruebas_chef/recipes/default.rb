#
# Cookbook:: vim_pruebas_chef
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Vamos a escribir algunas recetas que se aseguren de que Vim esté instalado, y usaremos las fuentes o los paquetes oficiales.

#En esta receta hemos incluido otra receta en función de un atributo que indica el método de instalación (node['vim']['install_method']), y captura la excepción si no existe una receta para el método de instalación especificado y muestra un mensaje al respecto.

begin
    include_recipe "vim_pruebas_chef::#{node['vim']['install_method']}" rescue 
    Chef::Exceptions::RecipeNotFound
    Chef::Log.warn"A #{node['vim']['install_method']} recipe does not exist for the platform_family: #{node['platform_family']}"
  end
  