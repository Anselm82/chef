require 'serverspec'
require 'rspec'
require 'pathname' 

set :backend, :exec
set :path, '/bin:/usr/local/bin:$PATH'