class GraphsController < ApplicationController

  def go_through_year year

  end

  def check_rate_of_hash day_to_check
    day = {}
    date = day_to_check
    date_after = time + 1.day
    day_of = date.strftime("%F")
    day_after = date_after.strftime("%F")
    day["count_per_day"] = InstagramArt.where(created_at: day_after..day_of).count
    day["day_per_count"] = day_to_check
    puts day.inspect
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
