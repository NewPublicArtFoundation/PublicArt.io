class PagesController < ApplicationController
  def home_web
    @graffitis = InstagramArt.page(1).per(30)
  end

  def explain
  end

  def about
  end

  def privacy
  end

  def thankyou
  end

  def partnerships
  end
end
