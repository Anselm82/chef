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
        expect(chef_run).to install_package('php-mysql')
      end
    end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('ghostscript')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-bcmath')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-curl')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-imagick')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-intl')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-json')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-mbstring')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-xml')
    end
  end
  context 'install php with default properties' do
    it 'php package installed' do
        expect(chef_run).to install_package('php-zip')
    end
  end
end

describe 'wordpress::default' do
  platform 'centos'
  
  context 'execute enable epel repository' do
    it 'execute enable epel repository' do
      expect(chef_run).to run_execute('enable epel repository').with(
        :command => "sudo yum -y install epel-release"
      )
    end
  end

  context 'copia remi-php72.repo template' do
    it 'create remi-php72.repo template' do
      expect(chef_run).to create_template("/etc/yum.repos.d/remi-php72.repo").with(
        :source => 'php/remi-php72.repo'
      )
    end
  end

  context 'execute enable php repository' do
    it 'execute enable php repository' do
      expect(chef_run).to run_execute('enable php repository').with(
        :command => "sudo sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/remi-php72.repo"
      )
    end
  end

  context 'execute install php' do
    it 'execute install php' do
      expect(chef_run).to run_execute('install php').with(
        :command => "sudo yum --enablerepo=remi-php72 install -y php php-fpm php-pdo php-pear php-mysql ghostscript php-bcmath php-curl php-json php-xml"
      )
    end
  end
  
end