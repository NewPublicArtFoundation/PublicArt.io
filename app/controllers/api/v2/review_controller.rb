module Api
  module V2
    class ReviewController < ApplicationController
      def get_location_for_id_array id_array
        location_arr = []
        id_array.each do |id|
          location = get_geojson_from_id id
          location_arr << location
        end
        return location_arr
      end

      def get_geojson_from_id id
        art = InstagramArt.find(id)
        geojson = {
          :type => "Feature",
          :discovered => art.created_at.iso8601,
          :geometry => {
            :type => "Point",
            :coordinates => [art.latitude, art.longitude]
          },
          :properties => {
            :title => art.image_url,
            :description => art.description
          }
        }
        return geojson
      end

      def query_current_flagged
        id_array = []
        # json = query url
        json.each do |content|
          id_array << content.id
        end
        return id_array
      end

      def flagged
        id_array = query_current_flagged
      end
    end
  end
end
