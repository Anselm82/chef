require 'spec_helper'

describe service('apache2') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port('80') do
  expect(command 'curl http://localhost').to return_stdout /.*<h1 class="site-title">DevOps<\/h1>.*/
end