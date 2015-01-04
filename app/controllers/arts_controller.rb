class ArtsController < ApplicationController
  def show
    uid = params[:id]
    art = InstagramArt.where(:uid => uid)
    @graffiti = art.first
  end

  def index
    @graffiti = InstagramArt.page params[:page]
  end

  def geojson_total
    @count = Geodata.all.count
    render :json => @count
  end

  def geojson
    @geojson = Geodata.find(params[:id])
    render :json => @geojson
  end

  def map_of_all
  end

  def check_if_image_exists id
    i = InstagramArt.find(id)

    url = i.image_url
    uri = URI(url)
    request = Net::HTTP.new uri.host
    response= request.request_head uri.path
    if response.code.to_i == 404
      i.delete
      puts "Image was bad for " + id.to_s
    else
      puts "Image is fine for " + id.to_s
    end
  end

  def process_images_for_404
    i = 0
    InstagramArt.find_each(batch_size: 2000) do |art|
      check_if_image_exists art.id
      i = i + 1
      puts 'Completed ' + i.to_s
    end
  end

  def get_aggregate_map_data
    map_datas = []
    i = 0
    InstagramArt.find_each(batch_size: 2000) do |art|
      i = i + 1
      map_data = {
          :type => 'Feature',
          :geometry => {
              :type => 'Point',
              :coordinates => [
                art.longitude,
                art.latitude
              ]
          },
          :properties => {
              :title => art.user_name + "'s photo",
              :description => art.longitude.to_s + ', ' + art.latitude.to_s,
              'marker-size' => 'small',
              'marker-color' => '#BE9A6B',
              :iconUrl => art.image_url,
              :iconSize => [50, 50]
          }
      }
      puts "Got: " + i.to_s
      g = Geodata.new(:purpose => art.uid, :content => map_data.to_json)
      g.save
    end
    puts 'FINISHED!'
  end
end
