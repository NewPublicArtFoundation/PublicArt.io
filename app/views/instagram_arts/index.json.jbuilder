json.array!(@instagram_arts) do |instagram_art|
  json.extract! instagram_art, :id, :everything, :image_url, :date_found, :tags, :caption, :user_name, :user_id, :user_avatar, :location_name, :location_lon, :location_lat, :location_id, :image_id
  json.url instagram_art_url(instagram_art, format: :json)
end
