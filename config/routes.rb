Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
  	namespace :v1 do
  		resource :registrations, only: [:create]
  		resource :otp_verifications, only: [:create]
  		resource :sessions, only: [:destroy]
  	end
  end
end
