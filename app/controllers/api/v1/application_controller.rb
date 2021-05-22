# frozen_string_literal: true

module Api
  module V1
    # application controller
    class ApplicationController < ActionController::API
      Swagger::Docs::Generator.set_real_methods
    end
  end
end
