class InstagramArt < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  before_create :set_uid

  protected
    def set_uid
      # This only works before_create obviously, otherwise it would
      # find itself and loop eternally.
      while self.uid.blank? or !InstagramArt.find_by_uid(self.uid).blank?
        self.uid = Digest::SHA1.hexdigest("--#{self.image_url}--#{Time.current.usec}--")
      end
    end
end
