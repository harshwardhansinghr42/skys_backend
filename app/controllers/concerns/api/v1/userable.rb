# frozen_string_literal: true

module Api
  module V1
    # user related controller operations
    module Userable
      extend ActiveSupport::Concern

      # find user
      def request_user
        @request_user ||= begin
          User.where(email: params[:email_or_phone])
              .or(User.where(phone: params[:email_or_phone]))
              .first
        end
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

      # render if user is not found
      def user_not_found
        return if @request_user

        render json: { errors: I18n.t('errors.user.not_found') },
               status: :unprocessable_entity
      end
    end
  end
end
