Rails.application.routes.draw do
    resources :routes
    resources :trips
    resources :stops
    resources :stop_times
    resources :calendar_dates
    resources :calendars
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
