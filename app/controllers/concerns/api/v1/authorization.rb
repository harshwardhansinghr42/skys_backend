# frozen_string_literal: true

module Api
  module V1
    # authorization
    module Authorization
      extend ActiveSupport::Concern
      included do
        before_action :authorize_user!
      end

      def authorize_user!
        return if @current_user.id == params[:id]&.to_i

        render json: { errors: [(I18n.t 'errors.user.not_authorized')] }, status: :unauthorized
      end
    end
  end
end
