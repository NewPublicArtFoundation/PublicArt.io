class InstagramArt < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  before_create :set_uid

  def self.remove_flagged arr
    arr.each do |a|
      if !InstagramArt.where(:id => a).empty?
        i = InstagramArt.find(a)
        i.flagged = true
        puts "Flagged image " + a.to_s
        i.save
      end
    end
  end

  def self.remove_bad_url
    InstagramArt.all.find_in_batches(start: 248917) do |group|
      # sleep(50) # Make sure it doesn't get too crowded in there!
      group.each do |person|
        id = person.id
        puts "Run at id: " + id.to_s
        RemoveUrlWorker.perform_async(id)
      end
    end
  end

  def self.check_id_url(id)
    puts 'Completing ' + id.to_s
    i = InstagramArt.find(id)
    uri = URI(i.image_url)
    request = Net::HTTP.new uri.host
    response = request.request_head uri.path
    if response.code.to_i == 404
      puts 'Was error'
      i.destroy
    else
      puts 'Working'
    end
  end

  def self.check_id_duplicate_image(id)
    puts 'Completing ' + id.to_s
    i = InstagramArt.find(id)
    if response.code.to_i == 404
      puts 'Was error'
      i.destroy
    else
      puts 'Working'
    end
  end

  def self.get_response_items @instagram_arts
    items = []

    @instagram_arts.each_with_index do |instagram_art, index|
      art_coordinates = [instagram_art.latitude, instagram_art.longitude]
      distance_apart = Geocoder::Calculations.distance_between(art_coordinates, @result_coordinates)
      item = {
        type: "Feature",
        distance: "#{distance_apart.round(2)}",
        discovered: instagram_art.created_at.iso8601,
        geometry: {
          type: "Point",
          coordinates: [ instagram_art.latitude ,  instagram_art.longitude ]
        },
        properties: {
          title: instagram_art.image_url,
          description: instagram_art.tags,
          count:  index ,
          id: instagram_art.id
        }
      }
      items << item
    end

    return items
  end

  # Used by indexlocation
  def self.index_json @instagram_arts
    len = @instagram_arts.length
    if(params.has_key?(:page))
      page_count = params[:page].to_i
      page_range_low = 1 + (10 * page_count)
    else
      page_count = 1
      page_range_low = 1
    end
    items = InstagramArts.get_response_items @instagram_arts
    result = {}
    result[:next] = @search_url.html_safe
    result[:count] = @result_count
    result[:low] = page_range_low
    result[:high] = page_range_low + 50
    response = {
      search_term: URI.encode(params[:search]),
      page_number: page_count,
      page_total: @instagram_arts.total_pages,
      result: result,
      data: items
    }
    return response
  end

  protected
    def set_uid
      # This only works before_create obviously, otherwise it would
      # find itself and loop eternally.
      while self.uid.blank? or !InstagramArt.find_by_uid(self.uid).blank?
        self.uid = Digest::SHA1.hexdigest("--#{self.image_url}--#{Time.current.usec}--")
      end
    end
end
