class ArtsController < ApplicationController
  def show
    uid = params[:id]
    art = InstagramArt.where(:uid => uid)
    @graffiti = art.first
  end

  def index
    @graffiti = InstagramArt.page params[:page]
  end
end
