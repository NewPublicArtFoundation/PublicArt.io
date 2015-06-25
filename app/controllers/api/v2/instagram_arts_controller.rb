module Api
  module V2
    class InstagramArtsController < ApplicationController

      # GET /find
      def indexlocation
        if params[:search].present?
          next_page = 1
          if params[:distance].present?
            @distance_from = params[:distance]
          else
            @distance_from = 5
          end
          if params[:page].present?
            next_page = params[:page].to_i + 1
          end
          @search_url = 'http://www.graffpass.com/find.json/?search=' + params[:search] + "&page=" + next_page.to_s

          if params[:orderby].present? && params[:orderby] == 'created_at'
            @instagram_arts = InstagramArt.order('created_at DESC').near(params[:search], @distance_from).where(flagged: nil).page params[:page]
            @result_count = InstagramArt.order('created_at DESC').near(params[:search], @distance_from).where(flagged: nil).count(:all)
          else
            @instagram_arts = InstagramArt.near(params[:search], @distance_from).where(flagged: nil).page params[:page]
            @result_count = InstagramArt.near(params[:search], @distance_from).where(flagged: nil).count(:all)
          end
          @result_coordinates = Geocoder.coordinates(params[:search])
          instagram_arts = @instagram_arts
          respond_to do |format|
            format.html {
              render :indexlocation
            }
            format.json {
              data = InstagramArts.index_json instagram_arts
              render json: data,
                     :content_type => 'application/json'
            }
          end
        end
      end

      # GET /instagram_arts/:id/image
      def image
        @instagram_arts = InstagramArt.find(params[:id])
        render plain: @instagram_arts.image_url
      end

    end
  end
end
