# frozen_string_literal: true

module Api
  module V1
    # states controller
    class StatesController < Api::V1::ApplicationController
      swagger_controller :states, 'State Controller'

      swagger_api :index do
        summary 'fetch states of a country'
        param_list :query, :country_code, :string, :required, 'Country Code', CS.countries.keys
      end

      def index
        country_code = params[:country_code] || 'IN'
        render json: CS.states(country_code)
      end
    end
  end
end
