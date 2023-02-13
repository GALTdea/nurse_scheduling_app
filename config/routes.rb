Rails.application.routes.draw do
resources :years do
  resources :weeks, only: :show
end

resources :weeks do
  resources :shifts
  member do
    post 'create_shifts'
    post 'balance_schedule'
  end
end
  

  resources :assignments

  resources :periods
  resources :nurses

  resources :shifts do
    resources :assignments, only: [:create]
    # post 'assigns/new', to: 'assignments#create'
  end 

  # resources :shifts

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "years#index"
end
=begin
 /shifts/:shift_id/assigns(.:format)      

 Started POST "/shifts/16/assigns/new" for ::1 at 2023-01-20 13:15:46 -0800
  
ActionController::RoutingError (No route matches [POST] "/shifts/16/assigns/new"):
=end