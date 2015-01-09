class InstagramImageWorker
  include Sidekiq::Worker

  def self.create index_zero
    if index_zero[:object] == 'tag'
      tag_name = index_zero[:object_id]
      store_tag_response tag_name
    end
    return true
  end

  def self.store_tag_response tag_name
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

  def self.create_pages_using_tags arts
    arts.each do |art|
      result = InstagramArt.where(:image_url=>art['image_url'])
      if(result == [])
        InstagramArt.create(art)
      end
    end
  end

  # Used by store_tag_response
  def self.parse_tags tags
    @arts = []

    tags.each do |tag|
      art = process_tag tags, tag
      puts 'Art is: ' + art.inspect
      if art["longitude"] != nil
        @arts << art
      end
    end

    return @arts
  end

  # Used by parse_tags
  def self.process_tag tags, tag
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
      art["longitude"]   = tag["location"]["longitude"]
      art["latitude"]   = tag["location"]["latitude"]
      art["location_id"]    = tag["location"]["id"]
    else
      art["location_name"]          = nil
    end

    return art
  end


  def self.get_tag
    tag_name = "streetart"
    last_called_id = ""
    client = Instagram.client(:access_token => session[:access_token])

    # tags = client.tag_recent_media(tag_name, :min_id => last_called_id)
    tags = client.tag_recent_media(tag_name)
    puts tags
  end

end
