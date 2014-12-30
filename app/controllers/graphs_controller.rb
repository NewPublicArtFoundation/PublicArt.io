class GraphsController < ApplicationController

  def check_rate_of_hash day_to_check
    day = {}
    time_before = day_to_check
    time = time.advance 86400
    date = Time.zone.now.beginning_of_day.ago 86400
    day["count_per_day"] = InstagramArt.where(:created_at => time_before.strftime("%F")..time.strftime("%F")).count
    day["day_per_count"] = time_before
    return day
  end

  def save_rate_of_hash day
    r = RateOfHash.new(:day_of => YAML::dump(day))
    r.save
  end

  def rate_of_new
    @per_day = RateOfHash.all
  end
end
