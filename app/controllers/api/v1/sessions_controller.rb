# frozen_string_literal: true

module Api
  module V1
    # sessions controller
    class SessionsController < Api::V1::ApplicationController
      before_action :user

      swagger_controller :sessions, 'User sessions'

      swagger_api :destroy do
        summary 'log user out of the system'
        param :form, 'id', :string, :required, 'User id'
        response :unprocessable_entity
      end

      def destroy
        @user.update(session_expired_at: Time.now)
        head :ok
      end

      private

      def user
        @user = User.find_by(id: params[:id])
        return if @user

        render json: { errors: I18n.t('errors.user.not_found') },
               status: :unprocessable_entity
      end
    end
  end
end
