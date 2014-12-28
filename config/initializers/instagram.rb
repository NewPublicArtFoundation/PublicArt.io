require "instagram"

Instagram.configure do |config|

  config.client_id = ENV['INSTAGRAM_PA_ID']

  config.access_token = ENV['INSTAGRAM_PA_TOKEN']

end
