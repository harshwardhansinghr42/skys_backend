module Api
  module V1
    class ApplicationController < ActionController::API
      include Swagger::Docs::ImpotentMethods
      def error_messages(_errors_arr)
        errors.full_messages.join(', ')
      end
    end
  end
end
