# frozen_string_literal: true

module Api
  module V1
    # user not found
    module UserNotFound
      extend ActiveSupport::Concern
      included do
        before_action :user_not_found
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
