class GraphsController < ApplicationController

  def rate_of_hash_yesterday
    day = {}
    now = Time.zone.now.beginning_of_day.ago 86400
    time = now.ago 86400
    time_before = time.ago 86400
    date = Time.zone.now.beginning_of_day.ago 86400
    day["count_per_day"] = InstagramArt.where(:created_at => time_before.strftime("%F")..time.strftime("%F")).count
    day["day_per_count"] = time
    r = RateOfHash.new(:day_of => YAML::dump(day))
    r.save
  end

  def rate_of_new
    @per_day = RateOfHash.all
  end
end
