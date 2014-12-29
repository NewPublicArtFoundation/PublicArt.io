class IntegrationController < ApplicationController

  def instagrams
  end

  def instagramOauthCallback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect root_path
  end

  def instagramOauthConnect
    redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  def instagramResponse
  end

  def instagram_realtime_response
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def flickr
  end
end
