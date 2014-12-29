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

        create index_zero
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def create index_zero
    if index_zero[:object] == 'tag'
      tag_name = index_zero[:object_id]
      store_tag_response tag_name
    end
    return true
  end

  def store_tag_response tag_name
    options = {}
    @arts = []
    if(InstagramArt.last() != nil)
      last_id = InstagramArt.last().image_id
      options = {
        :min_tag_id => last_id.to_i
      }
      tags = Instagram.tag_recent_media(tag_name, options)
      @arts = parse_tags tags
      create_pages_using_tags @arts
    end
  end

  def create_pages_using_tags arts
    arts.each do |art|
      result = InstagramArt.where(:image_url=>art['image_url'])
      if(result == [])
        InstagramArt.create(art)
      end
    end
  end

  # Used by store_tag_response
  def parse_tags tags
    @arts = []

    tags.each do |tag|
      art = process_tag tags, tag
      @arts << art
    end

    return @arts
  end

  # Used by parse_tags
  def process_tag tags, tag
    art = {}

    # art["everything"] = tag
    art["image_id"]   = tag["id"]
    art["image_url"]  = tag["images"]["standard_resolution"]["url"]
    art["date_found"] = tag["created_time"]

    if (tag["tags"] != nil)
      tag["tags"].each do |tag_result|
        if( tag_result != tag["tags"].first )
          tags = tags + ', ' + tag_result
        else
          tags = tag_result
        end
      end
    end

    art["tags"]           = tags

    if tag["caption"] != nil
      if tag["caption"]["text"] != nil
        art["caption"]        = tag["caption"]["text"]
      end
    else
      art["caption"]        = nil
    end

    art["user_name"]   = tag["user"]["username"]
    art["user_id"]     = tag["user"]["id"]
    art["user_avatar"] = tag["user"]["profile_picture"]

    if(tag["location"] != nil)
      art["location_name"]  = tag["location"]["name"]
      art["location_lon"]   = tag["location"]["longitude"]
      art["location_lat"]   = tag["location"]["latitude"]
      art["location_id"]    = tag["location"]["id"]
    else
      art["location_name"]          = nil
    end

    return art
  end


  def get_tag
    tag_name = "streetart"
    last_called_id = ""
    client = Instagram.client(:access_token => session[:access_token])

    # tags = client.tag_recent_media(tag_name, :min_id => last_called_id)
    tags = client.tag_recent_media(tag_name)
    puts tags
  end


end
