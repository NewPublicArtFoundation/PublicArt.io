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


  protected
    def set_uid
      # This only works before_create obviously, otherwise it would
      # find itself and loop eternally.
      while self.uid.blank? or !InstagramArt.find_by_uid(self.uid).blank?
        self.uid = Digest::SHA1.hexdigest("--#{self.image_url}--#{Time.current.usec}--")
      end
    end
end
