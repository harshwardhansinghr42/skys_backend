# frozen_string_literal: true

module Api
  module V1
    # cities controller
    class CitiesController < Api::V1::ApplicationController
      swagger_controller :cities, 'City Controller'

      swagger_api :index do
        summary 'fetch cities of a city'
        param_list :query, :country_code, :string, :required, 'Country Code', CS.countries.keys
        param_list :query, :state_code, :string, :required, 'State Code', CS.states(:IN).keys
      end

      def index
        country_code = params[:country_code] || 'IN'
        state_code = params[:state_code] || 'RJ'
        render json: CS.cities(state_code, country_code)
      end
    end
  end
end
