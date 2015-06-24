Rails.application.routes.draw do


  get 'review/flagged'

  # Authorization
  resources :accesskeys
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup


  get 'api/instagram'
  get 'integration/instagram'
  get 'integration/flickr'
  get 'status/rate' => 'graphs#rate_of_new'

  # Image Loading
  get 'most_recent/:id' =>  'instagram_arts#most_recent'

  # Static Pages
  get 'partnerships' =>     'pages#partnerships'
  get 'thanks' =>           'pages#thankyou'
  get 'explain' =>          'pages#explain'
  get 'about' =>            'pages#about'
  get 'privacy' =>          'pages#privacy'
  get 'about.html' =>       'pages#about'
  get 'privacy.html' =>     'pages#privacy'

  # Instagram Connect
  get   'api/instagram/oauth/connect' =>      'instagram_poll#oauth_connect'
  get   'api/instagram/callback' =>           'instagram_poll#oauth_callback'
  match 'api/instagram/callback/realtime' =>  'instagram_poll#realtime_response', via: :post
  get   'api/instagram/callback/realtime' =>  'instagram_poll#realtime_callback'

  # Web Views
  get 'v/'    => 'arts#index', :as => :arts_index
  get 'v/:id' => 'arts#show'
  get 'geojson/total' => 'arts#geojson_total'
  get 'geojson/:id' => 'arts#geojson'

  # iOS Views
  resources :instagram_arts, only: [:show]
  get 'slide' => 'instagram_arts#iosview'
  get 'find'  => 'instagram_arts#indexlocation'
  get 'instagram_arts/:id/image' => 'instagram_arts#image'
  root 'pages#home_web'

  get "*any", via: :all, to: "errors#not_found" #404

  namespace :ios do
    namespace :v1 do
      resources :instagram_arts, only: [:show]
      get 'slide' => 'instagram_arts#iosview'
      get 'find'  => 'instagram_arts#indexlocation'
      get 'instagram_arts/:id/image' => 'instagram_arts#image'
      root 'pages#home_web'
    end
  end

  namespace :api do
    namespace :v1 do
      # Login/Reg
    end
  end
end
