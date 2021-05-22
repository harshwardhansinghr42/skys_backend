# frozen_string_literal: true

# send user payment success email
class UserPaymentSuccessEmailService
  def initialize(razorpay_order)
    @razorpay_order = razorpay_order
    @user_email = @razorpay_order.user.email
  end

  def call
    params = {
      user_email: @user_email,
      razorpay_order: @razorpay_order,
      representative_contact_number: ENV['REPRESENTATIVE_CONTACT_NUMBER']
    }
    UserMailer.send_payment_success_email(params).deliver_now if @user_email
  end
end
