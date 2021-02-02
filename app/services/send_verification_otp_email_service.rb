class SendVerificationOtpEmailService
	def initialize(user)
		@user = user
	end

	def call
		UserMailer.send_verification_email(@user).deliver_now
	end
end