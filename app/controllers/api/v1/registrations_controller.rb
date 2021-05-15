# frozen_string_literal: true

module Api
  module V1
    # otp verification controller
    class RegistrationsController < Api::V1::ApplicationController
      include Api::V1::Userable
      before_action :request_user, :update_otp, :create_user

      def create
        if @request_user.valid?
          render json: @request_user
        else
          render_errors(@request_user)
        end
      end

      private

      # update otp
      def update_otp
        return unless @request_user

        @request_user.update_otp
      end

      # create user
      def create_user
        return unless @request_user.nil?

        @request_user = if params[:email_or_phone].match(User::EMAIL_REGEX)
                          User.create({ email: params[:email_or_phone] })
                        else
                          User.create({ phone: params[:email_or_phone] })
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
