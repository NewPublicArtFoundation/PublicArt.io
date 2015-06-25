module Api
  module V2
    class ArtsController < ApplicationController
      def geojson_total
        @count = Geodata.all.count
        render :json => @count
      end

      def geojson
        @geojson = Geodata.find(params[:id])
        render :json => @geojson
      end
    end
  end
end
