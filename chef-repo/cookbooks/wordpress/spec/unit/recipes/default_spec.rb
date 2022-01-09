describe 'wordpress::default' do
    platform 'ubuntu'

    #context 'install virtualbox-guest-additions-iso' do
    #    it 'installs virtualbox-guest-additions-iso packages' do
    #      expect(chef_run).to install_package 'virtualbox-guest-additions-iso'
    #    end
    #end
    
   # context 'includes recipes apache' do
    #    it 'includes the "wordpress::apache" recipe' do
     #       expect(chef_run).to include_recipe('wordpress::apache')
      #  end
    #end

    #context 'includes recipes mysql' do
     #   it 'includes the "wordpress::mysql" recipe' do
      #      expect(chef_run).to include_recipe('wordpress::mysql')
       # end
    #end

    #context 'includes recipes php' do
        #it 'includes the "wordpress::php" recipe' do
         #   expect(chef_run).to include_recipe('wordpress::php')
        #end
    #end

    #context 'includes recipes wordpress' do
     #   it 'includes the "wordpress::wordpress" recipe' do
      #      expect(chef_run).to include_recipe('wordpress::wordpress')
       # end
    #end
end

describe 'wordpress::default' do
    platform 'centos'
end