Rails.application.routes.draw do
  resources :accesskeys

  get 'api/instagram'
  get 'integration/instagram'
  get 'integration/flickr'
  get 'find'  => 'instagram_arts#indexlocation'
  # concern :paginatable do
  #   get '(page/:page)', :action => :index, :on => :collection, :as => ''
  # end
  get 'thanks' =>           'pages#thankyou'
  get 'explain' =>          'pages#explain'
  get 'about' =>            'pages#about'
  get 'privacy' =>          'pages#privacy'
  get 'about.html' =>       'pages#about'
  get 'privacy.html' =>     'pages#privacy'

  # Instagram Connect
  get 'api/instagram/oauth/connect' => 'api#instagram_oauth_connect'
  get 'api/instagram/callback' => 'api#instagram_oauth_callback'
  get 'api/instagram/callback/realtime' => 'api#instagram_realtime_callback'


  resources :instagram_arts, only: [:show]
  # resources :instagram_arts, :concerns => :paginatable
  get 'slide' => 'instagram_arts#iosview'
  get 'instagram_arts/:id/image' => 'instagram_arts#image'
  root 'pages#home_web'

  # get "*any", via: :all, to: "errors#not_found" #404
end
