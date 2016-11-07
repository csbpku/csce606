Rails.application.routes.draw do
  get 'trip_planner/index'
  root 'trip_planner#index'
  get 'as' => 'mapsearch#search'
  resources :routes
  resources :trips
  resources :stops
  resources :stop_times
  resources :calendar_dates
  resources :calendars
  resources :points
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
