class ApiController < ApplicationController

  def instagram
    params[:hashtag]
  end

  def instagram_callback
    params[:hashtag]
  end

end
