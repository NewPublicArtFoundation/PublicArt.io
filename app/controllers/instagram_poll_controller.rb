class InstagramPollController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:realtime_response]


  def oauth_connect
    redirect_to Instagram.authorize_url(:redirect_uri => ENV['INSTAGRAM_CALLBACK_URL'])
  end

  def oauth_callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => ENV['INSTAGRAM_CALLBACK_URL'])
    session[:access_token] = response.access_token
    redirect_to root_url
  end

  def realtime_callback
    if params["hub.challenge"]
      render :text => params["hub.challenge"]
    end
  end

  def realtime_response
    puts 'We got this: ' + params.inspect
    if params['_json'] != nil
      if params['_json'][0] != nil
        index_zero = params['_json'][0]
        object_id = params['_json'][0]['object_id']
        puts 'index 0 (inspect): ' + index_zero.inspect
        puts 'object_id (str): ' + object_id

        InstagramImageWorker.create(index_zero)


      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end
