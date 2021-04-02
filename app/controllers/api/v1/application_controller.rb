# frozen_string_literal: true

module Api
  module V1
    # application controller
    class ApplicationController < ActionController::API
      Swagger::Docs::Generator.set_real_methods
      def render_errors(request_user)
        render json: { errors: error_messages(request_user.errors) },
               status: :unprocessable_entity
      end

      def error_messages(errors_arr)
        errors_arr.full_messages.join(', ')
      end
    end
  end
end
