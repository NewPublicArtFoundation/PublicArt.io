include IndexLocation
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
          the_params = params
          search_url = @search_url

          if(params.has_key?(:page))
            page_count = params[:page].to_i
            page_range_low = 1 + (10 * page_count)
          else
            page_count = 1
            page_range_low = 1
          end

          len = instagram_arts.length
          items = IndexLocation.get_response_items instagram_arts
          result = {}
          result[:next] = @search_url.html_safe
          result[:count] = @result_count
          result[:low] = page_range_low
          result[:high] = page_range_low + 50
          response = {
            search_term: params[:search],
            page_number: page_count,
            page_total: @instagram_arts.total_pages,
            result: result,
            data: items
          }

          respond_to do |format|
            format.html {
              render :indexlocation
            }
            format.json {
              data = response
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
