url_to_go = ENV["REDISTOGO_URL"] ||= 'redis://username:password@host:1234/'
uri = URI.parse(url_to_go)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
