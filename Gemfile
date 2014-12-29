ruby '2.0.0'
source 'https://rubygems.org'

# Backend
gem 'rails', '4.1.2'
gem 'jbuilder', '~> 2.0'
gem 'spring',        group: :development
gem 'devise'

# Frontend
gem 'foundation-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# Geolocation
gem 'geocoder'

# Analytics
gem 'newrelic_rpm'

# External Services
gem 'instagram'

# Other
gem 'kaminari'
gem 'sdoc', '~> 0.4.0',          group: :doc

group :development do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  gem 'spork-rails', '4.0.0'
  gem 'childprocess', '0.3.6'
end

group :production do
  gem 'pg'
  gem 'rails_12factor', '0.0.2'
end
