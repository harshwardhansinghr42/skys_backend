# frozen_string_literal: true

# user model
class User < ApplicationRecord
  EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  OTP_EXPIRY_TIME = 10
  strip_attributes
  validate :email_or_phone_presence
  validates :phone, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, allow_nil: true,
                    format: EMAIL_REGEX

  def otp_expired?
    (Time.now - otp_created_at) / 1.minutes > User::OTP_EXPIRY_TIME
  end

  def update_otp
    self.otp = rand(1000...9999)
    self.otp_created_at = Time.now
    save!
  end

  private

  def email_or_phone_presence
    return if email || phone

    errors.add(:email, I18n.t('errors.user.email_or_phone_presence'))
  end
end
