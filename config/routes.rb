require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: :true) do
      resources :instagram_arts
      get 'geojson/total'   => 'arts#geojson_total'
      get 'geojson/:id'     => 'arts#geojson'
      get 'find'            => 'instagram_arts#indexlocation'
    end
  end

  namespace :ios do
    scope module: 'v1' do
      get 'instagram_arts/:id/image' => 'instagram_arts#image'
    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: :true) do
      resources :instagram_arts, only: [:show]
      get 'v/'    => 'arts#index', :as => :arts_index
      get 'v/:id' => 'arts#show'
      get 'slide' => 'instagram_arts#iosview'
      get 'instagram_arts/:id/image' => 'instagram_arts#image'
    end
  end

  scope module: 'web' do
    scope module: 'v1' do
      root 'pages#home_web'

      resources :accesskeys
      devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
      match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

      get 'status/rate' => 'graphs#rate_of_new'

      # Image Loading
      get 'most_recent/:id' =>  'instagram_arts#most_recent'

      get 'v/:id' => 'arts#show'
      get 'slide' => 'instagram_arts#iosview'
      get 'find'  => 'instagram_arts#indexlocation'
      get 'instagram_arts/:id/image' => 'instagram_arts#image'

      # Static Pages
      get 'partnerships' =>     'pages#partnerships'
      get 'thanks' =>           'pages#thankyou'
      get 'explain' =>          'pages#explain'
      get 'about' =>            'pages#about'
      get 'privacy' =>          'pages#privacy'
      get 'about.html' =>       'pages#about'
      get 'privacy.html' =>     'pages#privacy'

      get "*any", via: :all, to: "errors#not_found" #404
    end
  end

  namespace :external_interface do
    scope module: 'v1' do
      # Instagram Connect
      get   'instagram/oauth/connect' =>      'instagram_poll#oauth_connect'
      get   'instagram/callback' =>           'instagram_poll#oauth_callback'
      match 'instagram/callback/realtime' =>  'instagram_poll#realtime_response', via: :post
      get   'instagram/callback/realtime' =>  'instagram_poll#realtime_callback'

      get 'instagram'
      get 'instagram'
      get 'flickr'
    end
  end

  # Web Views
  resources :instagram_arts
  get 'v/'    => 'arts#index', :as => :arts_index
  get 'v/:id' => 'arts#show'
  get 'instagram_arts/:id/image' => 'instagram_arts#image'

end
