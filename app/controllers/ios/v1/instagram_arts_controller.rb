module Ios
  module V1
    class InstagramArtsController < ApplicationController
      before_action :set_instagramt_art, only: [:show, :edit, :update, :destroy, :vote]

      # GET /arts/1
      # GET /arts/1.json
      def image
        @instagram_arts = InstagramArt.find(params[:id])
        render plain: @instagram_arts.image_url
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_instagramt_art
          @instagram_arts = InstagramArt.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def instagramt_art_params
          params.require(:instagramt_arts).permit(:everything, :image_url, :date_found, :tags, :caption, :user_name, :user_id, :user_avatar, :location_name, :longitude, :latitude, :location_id, :image_id, :created_at, :updated_at)
        end

    end
  end
end
