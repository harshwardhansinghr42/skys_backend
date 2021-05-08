# frozen_string_literal: true

module Api
  module V1
    # otp verification controller
    class RegistrationsController < Api::V1::ApplicationController
      include Api::V1::Userable
      before_action :request_user, :create_user

      def create
        if @request_user.valid?
          render json: { user: @request_user }
        else
          render_errors(@request_user)
        end
      end

      swagger_controller :registrations, 'User Registration'

      swagger_api :create do
        summary 'create user registration'
        param :form, 'email_or_phone', :string, :optional, 'Email'
        response :unprocessable_entity
      end
    end
  end
end
