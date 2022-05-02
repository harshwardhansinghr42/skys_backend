# frozen_string_literal: true

module Api
  module V1
    # subscriptions controller
    class SubscriptionsController < Api::V1::ApplicationController
      swagger_controller :subscriptions, 'Subscriptions Controller'

      swagger_api :index do
        summary 'fetch all subscriptions'
      end

      def index
        result = {
          ss_subscriptions: Subscription::SS_SUBSCRIPTION,
          pp_subscriptions: Subscription::PP_SUBSCRIPTION
        }
        render_success('Records', result)
      end
    end
  end
end
