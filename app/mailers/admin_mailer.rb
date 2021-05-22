# frozen_string_literal: true

# admin mailer
class AdminMailer < ApplicationMailer
  helper :application
  def send_payment_success_email(razorpay_order)
    @razorpay_order = razorpay_order
    mail to: ENV['ADMIN_EMAIL'], subject: "SS/PP New Subscription | #{@razorpay_order.user_name}"
  end
end
