# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :registrations, only: [:create]
      resources :users, only: [] do
        member do
          resource :otp_verifications, only: [:create]
          resources :razorpay_orders, only: [:create, :index]
        end
      end
      resources :razorpay_orders, only: [] do
        member do
          resource :payment_successes, only: [:create]
        end
      end
      resource :sessions, only: [:destroy]
      resources :states, only: [:index]
      resources :cities, only: [:index]
      resources :subscriptions, only: [:index]
    end
  end
end
