json.array!(@accesskeys) do |accesskey|
  json.extract! accesskey, :id, :client_id, :client_secret, :callback_url, :source_url
  json.url accesskey_url(accesskey, format: :json)
end
