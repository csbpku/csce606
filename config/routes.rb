Rails.application.routes.draw do
  get 'trip_planner/index'
  root 'trip_planner#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
