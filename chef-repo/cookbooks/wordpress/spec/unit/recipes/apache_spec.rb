# Cookbook:: vim_pruebas_chef
# Spec:: apache
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# require 'spec_helper'

require 'spec_helper'

describe 'wordpress::default' do
  platform 'ubuntu'

  context 'install apache package' do
    it 'apache2 package installed' do
      expect(chef_run).to install_package('apache2')
    end
  end

  context 'librery apache php package' do
    it 'apache2 php library package installed' do
      expect(chef_run).to install_package('libapache2-mod-php')
    end
  end

  context 'delete default apache file' do
    it 'deletes the apache configuration file' do
      expect(chef_run).to delete_file('/etc/apache2/sites-enabled/000-default.conf')
    end 
  end

  context 'copy wordpress conf template' do
    it 'create wordpress conf' do  
      expect(chef_run).to create_template('/etc/apache2/sites-available/wordpress.conf').with(
        :source => 'apache/wordpress.conf'
      )
    end
  end

  context 'worpress conf link' do
    it 'creates link wordpress conf an other dir' do
      expect(chef_run).to create_link('/etc/apache2/sites-enabled/wordpress.conf')
    end
  end

  context 'rewrite load link' do
    it 'creates link rewrite load' do
      expect(chef_run).to create_link('/etc/apache2/mods-enabled/rewrite.load')
    end
  end

end

#describe 'wordpress::default' do
#  platform 'centos'

#  context 'install httpd package' do
#    it 'httpd package installed' do
#      expect(chef_run).to install_package 'httpd'
#    end
#  end
  
#end