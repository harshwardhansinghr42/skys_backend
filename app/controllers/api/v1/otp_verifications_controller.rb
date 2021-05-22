# frozen_string_literal: true

module Api
  module V1
    # otp verification controller
    class OtpVerificationsController < Api::V1::ApplicationController
      include Api::V1::RequestUser
      include Api::V1::UserNotFound
      before_action :invalid_otp

      swagger_controller :otp_verifications, 'Otp Verification'

      swagger_api :create do
        summary 'user otp verification'
        param :form, 'email_or_phone', :string, :optional, 'Email'
        param :form, 'otp', :string, :optional, 'otp'
        response :unprocessable_entity
      end

      def create
        render json: { AuthenticationToken: JsonWebToken.generate_token(@request_user.id) }
      end

      private

      def invalid_otp
        return if !@request_user.otp_expired? &&
                  @request_user.otp == params[:otp]

        render json: { errors: I18n.t('errors.user.otp_invalid') },
               status: :unprocessable_entity
      end
    end
  end
end
