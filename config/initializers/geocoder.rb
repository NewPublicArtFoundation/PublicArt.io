Geocoder.configure({
  lookup: :bing,
  key: ENV['BING_GEOCODE_ID'],
  cache: Rails.cache,
  api_key: key
})