Rails.application.routes.draw do
  root 'trip_planner#index'
  get 'trip_planner/index'
  post 'trip_planner/trip_planning'
  get 'trip_planner/trip_planning'
  get 'trip_planner/display_route'
  
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

