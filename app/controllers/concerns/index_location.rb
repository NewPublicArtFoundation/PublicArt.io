    module IndexLocation
      extend ActiveSupport::Concern

      def get_response_items instagram_arts
        items = []

        instagram_arts.each_with_index do |instagram_art, index|
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

    end
