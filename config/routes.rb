Rails.application.routes.draw do
  root 'trip_planners#index'
  get 'trip_planners/index'
  post 'trip_planners/bus_route_planning'
  get 'trip_planners/display_route'
  
  get 'as' => 'mapsearch#search'
  get 'dropPins'=>'layers#dropPins'

  resources :routes
  resources :trips
  resources :stops
  resources :stop_times
  resources :calendar_dates
  resources :calendars
  resources :points
  
  resources :cars
  resources :buildings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

