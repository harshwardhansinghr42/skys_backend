# frozen_string_literal: true

# Payment Success
class PaymentSuccess < ApplicationRecord
  belongs_to :razorpay_order

  before_save :verify_signature
  after_create_commit :send_emails

  private

  def verify_signature
    payment_response = {
      razorpay_order_id: razorpay_order.order_id,
      razorpay_payment_id: razorpay_payment_id,
      razorpay_signature: razorpay_signature
    }
    self.signature_verified = Razorpay::Utility.verify_payment_signature(payment_response)
  rescue SecurityError
    PaymentFailureLogsService.new('Signature Verification Failed', payment_response).call
    throw(:abort)
  end

  def send_emails
    return unless signature_verified

    AdminPaymentSuccessEmailService.new(razorpay_order).call
    UserPaymentSuccessEmailService.new(razorpay_order).call
  end
end
