class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:instagram_realtime_response]

end
