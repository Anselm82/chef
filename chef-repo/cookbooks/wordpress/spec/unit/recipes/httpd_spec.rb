# Cookbook:: vim_pruebas_chef
# Spec:: apache
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# require 'spec_helper'

require 'spec_helper'

describe 'wordpress::default' do
  platform 'centos'

  context 'install httpd package' do
    it 'httpd package installed' do
      expect(chef_run).to install_package 'httpd'
    end
  end

  context 'create directory sites-available' do
    it 'create directory sites-available' do
      expect(chef_run).to create_directory('/etc/httpd/sites-available')
    end
  end

  context 'create directory sites-enabled' do
    it 'create directory sites-enabled' do
      expect(chef_run).to create_directory('/etc/httpd/sites-enabled')
    end
  end

  #execute "update config" do
  #  command "echo \"IncludeOptional sites-enabled/*.conf\" >> /etc/httpd/conf/httpd.conf"
  #  notifies :restart, resources(:service => "httpd")
  #end

  context 'delete default httpd file centos' do
    it 'deletes the httpd configuration file centos' do
      expect(chef_run).to delete_file('/etc/httpd/sites-enabled/000-default.conf')
    end 
  end

  context 'copy wordpress conf template centos' do
    it 'create wordpress conf centos' do  
      expect(chef_run).to create_template('/etc/httpd/sites-available/wordpress.conf').with(
        :source => 'apache/wordpress.conf'
      )
    end
  end

  context 'worpress conf link' do
    it 'creates link wordpress conf an other dir' do
      expect(chef_run).to create_link('/etc/httpd/sites-enabled/wordpress.conf').with(
        :to => '/etc/httpd/sites-available/wordpress.conf'
      )
    end
  end
  
end