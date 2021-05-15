# frozen_string_literal: true

module Api
  module V1
    # user related controller operations
    module Userable
      extend ActiveSupport::Concern

      # find user
      def request_user
        return unless params[:email_or_phone].present?

        @request_user ||= begin
          User.where(email: params[:email_or_phone])
              .or(User.where(phone: params[:email_or_phone]))
              .first
        end
      end

      # render if user is not found
      def user_not_found
        return if @request_user

        render json: { errors: I18n.t('errors.user.not_found') },
               status: :unprocessable_entity
      end
    end
  end
end
