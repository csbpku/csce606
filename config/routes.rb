Rails.application.routes.draw do
  root 'trip_planner#index'
  get 'trip_planner/index'
  post 'trip_planner/trip_planning'
  get 'trip_planner/display_route'
  
  get 'dropPins'=>'layers#dropPins'
  
  get '/auth/:provider/callback', :to =>  'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/logout', :to => 'sessions#destroy'
  
  get 'auth_failure' => 'sessions#auth_failure'

  resources :routes
  resources :trips
  resources :stops
  resources :stop_times
  resources :calendar_dates
  resources :calendars
  resources :points
  
  resources :cars
  resources :buildings
  resources :users
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

