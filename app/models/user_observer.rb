class UserObserver < ActiveRecord::Observer
	def before_create(user)
		user.otp = rand(1000...9999)
		user.otp_created_at = Time.now
	end

	def after_save(user)
		return unless user.saved_change_to_otp?

		SendVerificationOtpSmsService.new(user).call if user.phone
		SendVerificationOtpEmailService.new(user).call if user.email
	end
end