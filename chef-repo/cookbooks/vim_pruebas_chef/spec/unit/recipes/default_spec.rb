#
# Cookbook:: vim_pruebas_chef
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# require 'spec_helper'

# describe 'vim_pruebas_chef::default' do
#   context 'When all attributes are default, on Ubuntu 18.04' do
#     # for a complete list of available platforms and versions see:
#     # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
#     platform 'ubuntu', '18.04'

#     it 'converges successfully' do
#       expect { chef_run }.to_not raise_error
#     end
#   end

#   context 'When all attributes are default, on CentOS 7' do
#     # for a complete list of available platforms and versions see:
#     # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
#     platform 'centos', '7'

#     it 'converges successfully' do
#       expect { chef_run }.to_not raise_error
#     end
#   end
# end

require 'spec_helper'

describe 'vim_pruebas_chef::default' do
  platform 'ubuntu'

  context 'with default attributes' do
    it "should have default install_method 'package'" do
     expect(chef_run.node['vim']['install_method']).to eq('package') 
    end

    it "should include the vim_pruebas_chef::package recipe when install_method='package'" do 
      expect(chef_run).to include_recipe('vim_pruebas_chef::package') 
    end
  end
  
  context "with 'source' as install_method" do
    
    override_attributes['vim']['install_method'] = 'source' 

    it "should include the vim_pruebas_chef::source recipe when install_method='source'" do 
      expect(chef_run).to include_recipe('vim_pruebas_chef::source') 
    end
  end
end


