class ArtsController < ApplicationController
  def show
    uid = params[:id]
    @graffiti = InstagramArt.where(:uid => uid)
  end

  def index
    @graffiti = InstagramArt.page params[:page]
  end
end
