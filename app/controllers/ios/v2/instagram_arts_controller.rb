module Ios
  module V2
    class InstagramArtsController < ApplicationController
      before_action :set_instagramt_art, only: [:show, :edit, :update, :destroy, :vote]

      # GET /arts
      # GET /arts.json
      def index
        @instagram_arts = InstagramArt.page params[:page]
      end


      def most_recent
        graffitis = InstagramArt.page(params[:id]).per(30)
        blocks = []
        graffitis.each do |graffiti|
          html = '<li class="text-center"><img src="' + graffiti.image_url + '"></li>'
          blocks << html
        end
        @fragment = blocks.join('')
        respond_to do |format|
            format.html {
              render plain: @fragment.html_safe
            }
          end
      end

      def redirect_to_index
        redirect_to find_url
      end

      def show_web
        uid = params[:id]
        @instagram_arts = InstagramArt.find(uid)
      end

      # GET /arts
      # GET /arts.json
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
          respond_to do |format|
            format.html {
              render :indexlocation
            }
            format.json {
              data = index_json
              render json: data,
                     :content_type => 'application/json'
            }
          end
        end
      end

      def index_json
        len = @instagram_arts.length
        if(params.has_key?(:page))
          page_count = params[:page].to_i
          page_range_low = 1 + (10 * page_count)
        else
          page_count = 1
          page_range_low = 1
        end
        items = get_response_items
        result = {}
        result[:next] = @search_url.html_safe
        result[:count] = @result_count
        result[:low] = page_range_low
        result[:high] = page_range_low + 50
        response = {
          search_term: URI.encode(params[:search]),
          page_number: page_count,
          page_total: @instagram_arts.total_pages,
          result: result,
          data: items
        }
        return response
      end

      def get_response_items
        items = []

        @instagram_arts.each_with_index do |instagram_art, index|
          art_coordinates = [instagram_art.latitude, instagram_art.longitude]
          distance_apart = Geocoder::Calculations.distance_between(art_coordinates, @result_coordinates)
          item = {
            type: "Feature",
            distance: "#{distance_apart.round(2)}",
            discovered: instagram_art.created_at.iso8601,
            geometry: {
              type: "Point",
              coordinates: [ instagram_art.latitude ,  instagram_art.longitude ]
            },
            properties: {
              title: instagram_art.image_url,
              description: instagram_art.tags,
              count:  index ,
              id: instagram_art.id
            }
          }
          items << item
        end

        return items
      end

      # GET /arts/1
      # GET /arts/1.json
      def show
        @distance_away = ""
        if(params[:dist] != nil)
          @distance_away = params[:dist]
        end
        @instagram_arts = InstagramArt.find(params[:id])
      end

      # GET /arts/1
      # GET /arts/1.json
      def image
        @instagram_arts = InstagramArt.find(params[:id])
        render plain: @instagram_arts.image_url
      end

      # GET /arts/new
      def new
        @instagram_arts = InstagramArt.new
      end

      # GET /arts/1/edit
      def edit
      end

      # POST /arts
      # POST /arts.json
      def create
        @instagram_arts = InstagramArt.new(instagramt_art_params)
        @instagram_arts_uploads = @instagram_arts.uploads.build

        respond_to do |format|
          if @instagram_arts.save
            format.html { redirect_to root_url, notice: 'Art was successfully created.' }
            format.json { render :show, status: :created, location: @instagram_arts }
          else
            format.html { render :new }
            format.json { render json: @instagram_arts.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /arts/1
      # PATCH/PUT /arts/1.json
      def update
        respond_to do |format|
          if @instagram_arts.update(instagramt_art_params)
            track_activity @instagram_arts
            format.html { redirect_to @instagram_arts, notice: 'Art was successfully updated.' }
            format.json { render :show, status: :ok, location: @instagram_arts }
          else
            format.html { render :edit }
            format.json { render json: @instagram_arts.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /arts/1
      # DELETE /arts/1.json
      def destroy
        @instagram_arts.destroy
        respond_to do |format|
          format.html { redirect_to arts_url, notice: 'Art was successfully destroyed.' }
          format.json { head :no_content }
        end
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
