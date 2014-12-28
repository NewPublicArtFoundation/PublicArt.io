Rails.application.routes.draw do
  resources :accesskeys

  get 'integration/instagram'
  get 'integration/flickr'
  get 'find'  => 'instagram_arts#indexlocation'
  # concern :paginatable do
  #   get '(page/:page)', :action => :index, :on => :collection, :as => ''
  # end
  get 'explain' =>          'pages#explain'
  get 'about' =>            'pages#about'
  get 'privacy' =>          'pages#privacy'
  get 'about.html' =>       'pages#about'
  get 'privacy.html' =>     'pages#privacy'

  resources :instagram_arts, only: [:show]
  # resources :instagram_arts, :concerns => :paginatable
  get 'slide' => 'instagram_arts#iosview'
  get 'instagram_arts/:id/image' => 'instagram_arts#image'
  root 'instagram_arts#indexlocation'

end
