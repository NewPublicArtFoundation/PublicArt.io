class ApiController < ApplicationController

  def instagram_oauth_connect
    redirect_to Instagram.authorize_url(:redirect_uri => ENV['INSTAGRAM_CALLBACK_URL'])
  end

  def instagram_oauth_callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => ENV['INSTAGRAM_CALLBACK_URL'])
    session[:access_token] = response.access_token
    redirect_to root_url
  end

  def instagram_realtime_callback
    if params["hub.challenge"]
      render :text => params["hub.challenge"]
    end
  end

  def instagram_realtime_response
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end
