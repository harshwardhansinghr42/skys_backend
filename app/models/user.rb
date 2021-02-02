class User < ApplicationRecord
	strip_attributes
	validate :email_or_phone_presence
	validates :phone, uniqueness: true, allow_nil: true
	validates :email, uniqueness: true, allow_nil: true,
						format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	private

	def email_or_phone_presence
		return if email || phone

		self.errors.add(:email, I18n.t('errors.user.email_or_phone_presence'))
  end
end
