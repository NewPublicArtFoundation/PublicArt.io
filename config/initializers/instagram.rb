require "instagram"

Instagram.configure do |config|

  config.client_id = ENV['INSTAGRAM_PA_ID']
  config.client_secret = ENV['INSTAGRAM_PA_TOKEN']


end
