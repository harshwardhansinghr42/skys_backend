# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :registrations, only: [:create]
      resource :otp_verifications, only: [:create]
      resource :sessions, only: [:destroy]
      resources :states, only: [:index]
      resources :cities, only: [:index]
      resource :razorpay_orders, only: [:create]
      resource :payment_successes, only: [:create]
      resource :payment_failures, only: [:create]
    end
  end
end
