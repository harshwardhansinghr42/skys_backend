# frozen_string_literal: true

# send admin payment success email
class AdminPaymentSuccessEmailService
  def initialize(razorpay_order)
    @razorpay_order = razorpay_order
  end

  def call
    AdminMailer.send_payment_success_email(@razorpay_order).deliver_now
  end
end
