require 'rspec'
require 'pathname' 

set :backend, :exec
set :path, '/bin:/usr/local/bin:$PATH'

#Testing apache port is listening
describe port(node['apache']['port']), :skip do
    it { should be_listening }
end

#apache tests
#require 'serverspec/apache_spec'

#mysql tests
#require 'serverspec/mysql_spec'

#php tests
#require 'serverspec/php_spec'

#wordpress tests
#require 'serverspec/wordpress_spec'