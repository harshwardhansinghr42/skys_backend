# frozen_string_literal: true

module Api
  module V1
    # payment failures controller
    class PaymentFailuresController < Api::V1::ApplicationController
      include Api::V1::Authentication

      swagger_controller :payment_failures, 'Payment Failures'

      swagger_api :create do
        summary 'create payment failures'
        param :header, 'AuthenticationToken', :string, :required, 'Authentication token'
        param :form, 'error_code', :string, :required, 'error code'
        param :form, 'error_description', :string, :required, 'error description'
        param :form, 'error_source', :string, :required, 'error source'
        param :form, 'error_step', :string, :required, 'error step'
        param :form, 'error_reason', :string, :required, 'error reason'
        param :form, 'error_metadata_order_id', :string, :required, 'error metadata order id'
        param :form, 'error_metadata_payment_id', :string, :required, 'error metadata payment id'
        param :form, 'razorpay_order_id', :string, :required, 'razorpay order id'
        response :unprocessable_entity
      end

      def create
        PaymentFailureLogsService.new('Payment Failed at Client side', payment_failure_params).call
        head :ok
      end

      private

      def payment_failure_params
        params.permit(
          :error_code, :razorpay_signature, :error_description,
          :error_source, :error_step, :error_reason,
          :error_metadata_order_id, :error_metadata_payment_id,
          :razorpay_order_id
        )
      end
    end
  end
end
