# frozen_string_literal: true

module Api
  module V1
    # request user
    module RequestUser
      extend ActiveSupport::Concern
      included do
        before_action :request_user
      end

      # find user
      def request_user
        return unless params[:email_or_phone].present? || params[:id].present?

        if params[:email_or_phone].present?
          @request_user ||= begin
            User.where(email: params[:email_or_phone])
                .or(User.where(phone: params[:email_or_phone]))
                .first
          end
        end

        @request_user ||= User.find_by(id: params[:id]) if params[:id].present?
      end
    end
  end
end
