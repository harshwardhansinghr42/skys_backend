# frozen_string_literal: true

module Api
  module V1
    # application controller
    class ApplicationController < ActionController::API
      Swagger::Docs::Generator.set_real_methods
      include Api::V1::ErrorMessage
      include Api::V1::Authentication
    end
  end
end
