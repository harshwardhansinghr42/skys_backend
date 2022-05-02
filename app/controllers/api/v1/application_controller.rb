# frozen_string_literal: true

module Api
  module V1
    # application controller
    class ApplicationController < ActionController::API
      Swagger::Docs::Generator.set_real_methods

      def render_success(message, result, serializer = nil)
        obj = {
          message: message,
          status: true,
          data: serialized_result(result, serializer)
        }
        render json: obj, status: status
      end

      def serialized_result(result, serializer)
        return result unless serializer

        if result.is_a?(Array)
          ActiveModel::SerializableResource.new(result, each_serializer: serializer)
        else
          ActiveModel::SerializableResource.new(result, serializer: serializer)
        end
      end
    end
  end
end
