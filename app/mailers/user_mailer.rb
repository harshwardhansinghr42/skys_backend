# frozen_string_literal: true

# user mailer
class UserMailer < ApplicationMailer
  helper :application
  def send_verification_email(user)
    @otp = user.otp
    mail to: user.email, subject: 'User Verification OTP'
  end

  def send_payment_success_email(params)
    @razorpay_order = params[:razorpay_order]
    @representative_contact_number = params[:representative_contact_number]
    mail to: params[:user_email], subject: 'Subscription Bought Successfully'
  end
end
