# This is an example test, replace it with your own test.
describe port(default['apache']['port']), :skip do
    it { should be_listening }
end
  