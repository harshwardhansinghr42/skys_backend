# frozen_string_literal: true

module Api
  module V1
    # razorpay orders controller
    class RazorpayOrdersController < Api::V1::ApplicationController
      include Api::V1::Authentication
      include Api::V1::ErrorMessage

      swagger_controller :razorpay_orders, 'Razorpay Orders'

      swagger_api :create do
        summary 'create razorpay orders'
        param :header, 'AuthenticationToken', :string, :required, 'Authentication token'
        param_list :form, 'ss_subscription_period', :string, :optional,
                   'sanghshakti subscription period', %i[one_year five_year ten_year]
        param_list :form, 'pp_subscription_period', :string, :optional,
                   'pathprerak subscription period', %i[one_year five_year ten_year]
        param :form, 'user_name', :string, :required, 'user full name'
        param :form, 'user_address', :string, :required, 'user full address'
        param :form, 'user_state', :string, :required, 'user state'
        param :form, 'user_city', :string, :required, 'user city'
        param :form, 'user_pincode', :string, :required, 'user pincode'
        param :form, 'user_phone', :string, :required, 'user phone'
        response :unprocessable_entity
      end

      def create
        razorpay_order = @current_user.razorpay_orders.new(razorpay_orders_params)
        if razorpay_order.save
          order_created_response = ActiveModel::SerializableResource.new(razorpay_order,
                                                                         serializer: OrderCreatedResponseSerializer)
          render json: { razorpay_order: order_created_response.as_json }
        else
          render_errors(razorpay_order)
        end
      end

      private

      def razorpay_orders_params
        params.permit(:ss_subscription_period, :pp_subscription_period, :user_name, :user_address,
                      :user_state, :user_city, :user_pincode, :user_phone)
      end
    end
  end
end
