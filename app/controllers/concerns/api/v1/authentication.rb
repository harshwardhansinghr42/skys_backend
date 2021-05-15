# frozen_string_literal: true

module Api
  module V1
    # authentication
    module Authentication
      extend ActiveSupport::Concern

      def authenticate_user!
        return if valid_token?

        @current_user = nil
        render json: { errors: [(I18n.t 'errors.user.not_authenticated')] }, status: :unauthorized
      end

      def valid_token?
        return false unless auth_token

        @current_user = User.find_by(id: auth_token['user_id'])
        return false unless @current_user

        return true if @current_user.session_expired_at.nil?

        auth_token['token_generation_time'] > @current_user.session_expired_at
      end

      def auth_token
        @auth_token ||= JsonWebToken.decode(request.headers['AuthenticationToken'])
      end
    end
  end
end
