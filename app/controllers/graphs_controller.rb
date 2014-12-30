class GraphsController < ApplicationController

  def go_through_year year

  end

  def create_year
    for i in 1..364
      m = 365 - i
      seconds = m * 86400
      time = Time.now.ago seconds
      day_to_check = time
      day = check_rate_of_hash day_to_check
      save_rate_of_hash day
    end
  end

  def check_rate_of_hash day_to_check
    day = {}
    date = day_to_check
    date_after = date + 1.day
    day_of = date.beginning_of_day.strftime("%F")
    day_after = date_after.beginning_of_day.strftime("%F")
    day["count_per_day"] = InstagramArt.where(created_at: day_of..day_after).count
    day["day_per_count"] = day_of
    puts day.inspect
    return day
  end

  def save_rate_of_hash day
    r = RateOfHash.new(:day_of => YAML::dump(day))
    r.save
  end

  def rate_of_new
    @rates = RateOfHash.all
    all_days = []
    all_rates = []
    @rates.each do |rate|
      day_of = YAML::load(rate.day_of)
      @all_days << day_of['day_per_count']
      @all_rates << day_of['count_per_day']
    end
  end
end
