class UserMailer < ApplicationMailer
	def send_verification_email(user)
		@otp = user.otp
		mail to: user.email, subject: 'User Verification OTP'
	end
end