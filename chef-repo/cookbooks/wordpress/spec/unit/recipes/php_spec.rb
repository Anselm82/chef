require 'spec_helper'

describe 'wordpress::default' do
  platform 'ubuntu'

  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-mysql'
      end
    end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'ghostscript'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-bcmath'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-curl'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-imagick'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-intl'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-json'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-mbstring'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-xml'
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package 'php-zip'
    end
  end
end

describe 'wordpress::default' do
  platform 'centos'
  
  
end