Rails.application.routes.draw do
  resources :car_informations
  resources :cars

  get '/get_average_consumption_data/:vin', to: 'car_informations#get_average_consumption'
  get '/get_average_rpm_data/:vin', to: 'car_informations#get_average_rpm'
  get '/get_distance_traveled_data/:vin', to: 'car_informations#get_distance_traveled'
  get '/get_time_traveled_data/:vin', to: 'car_informations#get_time_traveled'
  get '/get_all_data/:vin', to: 'car_informations#get_all_data'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
