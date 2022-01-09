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
  
end