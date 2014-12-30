class GraphsController < ApplicationController

  def rate_of_hash_over_year
    @per_day = []
    for j in 1...365
      i = 365-j
      day = {}
      now = Time.zone.now.beginning_of_day
      time = now.ago i*86400
      time_before = time.ago 86400
      date = Time.zone.now.beginning_of_day.ago i*86400
      day["count_per_day"] = InstagramArt.where(:created_at => time.strftime("%F")..time_before.strftime("%F")).count
      day["day_per_count"] = time
      r = RateOfHash.new(:day_of => YAML::dump(day))
      r.save
    end
  end

  def rate_of_new
    @per_day = RateOfHash.all
  end
end
