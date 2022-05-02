# frozen_string_literal: true

module Api
  module V1
    # payment successes controller
    class PaymentSuccessesController < Api::V1::ApplicationController
      include Api::V1::Authentication
      before_action :razorpay_order

      swagger_controller :payment_successes, 'Payment Successes'

      swagger_api :create do
        summary 'create payment successes'
        param :header, 'AuthenticationToken', :string, :required, 'Authentication token'
        param :path, 'id', :integer, :required, 'razorpay order id'
        param :form, 'razorpay_payment_id', :string, :required, 'razorpay response payment id'
        param :form, 'razorpay_order_id', :string, :required, 'razorpay response order id'
        param :form, 'razorpay_signature', :string, :required, 'razorpay response signature'
        response :unprocessable_entity
      end

      def create
        payment_success = @razorpay_order.payment_successes.new(payment_successes_params)
        if payment_success.save && payment_success.signature_verified
          head :ok
        else
          render json: { errors: 'something went wrong. please try again later' }
        end
      end

      private

      def razorpay_order
        @razorpay_order = RazorpayOrder.find_by(id: params[:id])
        return if @razorpay_order

        render json: { errors: I18n.t('errors.razorpay_order.not_found') },
               status: :unprocessable_entity
      end

      def payment_successes_params
        params.permit(:razorpay_payment_id, :razorpay_signature)
      end
    end
  end
end
