class InstagramArt < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  before_create :set_uid
  default_scope -> { order(created_at: :desc) }

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

  protected
    def set_uid
      # This only works before_create obviously, otherwise it would
      # find itself and loop eternally.
      while self.uid.blank? or !InstagramArt.find_by_uid(self.uid).blank?
        self.uid = Digest::SHA1.hexdigest("--#{self.image_url}--#{Time.current.usec}--")
      end
    end
end
