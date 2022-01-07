apt_update 'Update the apt cache daily' do
  frequency 86400
  action :periodic
end

include_recipe '::apache'
include_recipe '::mysql'
include_recipe '::php'
include_recipe '::wordpress'
