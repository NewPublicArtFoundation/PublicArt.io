module Web
  module V1
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
