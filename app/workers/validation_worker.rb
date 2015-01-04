class ValidationWorker
  include Sidekiq::Worker

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
end
