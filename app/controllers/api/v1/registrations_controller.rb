module Api
	module V1
		class RegistrationsController < Api::V1::ApplicationController
			before_action :request_user
			def create
				if @request_user.valid?
					render json: @request_user
				else
					render json: { errors: error_messages(@request_user.errors) }
				end
			end

			swagger_controller :registrations, 'User Registration',
												 resource_path: 'api/v1/registrations'

		  swagger_api :create do
		    summary 'create user registration'
		    param :form, 'user[email]', :string, :optional, 'Email'
		    param :form, 'user[phone]', :string, :optional, 'Phone'
		    response :unprocessable_entity
		  end
		end
	end
end