require 'spec_helper'

#Podemos también generar dinámicamente los casos de prueba para múltiples plataformas utilizando código Ruby. En este ejemplo se itera por la lista de plataformas y versiones, y se generan los casos de prueba dinámicamente en función de ellos, cada uno define las expectativas de los paquetes necesarios que se instalarán.

describe 'vim_pruebas_chef::package' do
  package_checks = {
    'ubuntu' => {
      '16.04' => ['vim'],
      '18.04' => ['vim'],
      '20.04' => ['vim'],
    },
    'debian' => {
      '8.11' => ['vim'],
      '9.11' => ['vim'],
      '10' => ['vim']
    },
    'redhat'=> {
      '7.7'=> ['vim-minimal','vim-enhanced'] ,
      '8'=> ['vim-minimal','vim-enhanced']
    }
  }
  
  package_checks.each do |platform, versions|
    versions.each do |version, packages|
      packages.each do |package_name|
        it "should install #{package_name} on #{platform} #{version}" do
          chef_run = ChefSpec::SoloRunner.new(platform: platform, version: version, file_cache_path: '/var/chef/cache') do |node|
            node.normal['vim']['install_method'] = 'package'
          end.converge(described_recipe)
          expect(chef_run).to install_package(package_name)
        end
      end
    end
  end
end
