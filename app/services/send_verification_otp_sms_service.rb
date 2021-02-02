class SendVerificationOtpSmsService
	def initialize(user)
		@user = user
	end

	def call
		MessageService.new(@user.phone, message).call
	end

	def message
		"Please use code #{@user.otp} as your one time password to login.
		 This code will expire in 10 minutes."
	end
end