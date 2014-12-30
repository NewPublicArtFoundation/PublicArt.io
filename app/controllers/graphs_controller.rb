class GraphsController < ApplicationController

  def rate_of_new
    @per_day = []
    for i in 1...365
      day = {}
      now = Time.zone.now.beginning_of_day
      time = now.ago i*86400
      time_before = time.ago 86400
      date = Time.zone.now.beginning_of_day.ago i*86400
      day["count_per_day"] = InstagramArt.where(:created_at => time.strftime("%F")..time_before.strftime("%F")).count
      day["day_per_count"] = time
      @per_day << day
    end
  end
end
