# frozen_string_literal: true

# Razorpay Orders
class RazorpayOrder < ApplicationRecord
  enum ss_subscription_period: %i[one_year five_year ten_year], _prefix: true
  enum pp_subscription_period: %i[one_year five_year ten_year], _prefix: true

  validates :order_id, :user_name, :user_address, :user_city,
            :user_state, :user_pincode, :user_phone, presence: true
  validate :ss_or_pp_should_be_present

  # this amount is in paise not in rupees
  SS_SUBSCRIPTION_CHARGES = {
    'one_year' => 15_000,
    'five_year' => 70_000,
    'ten_year' => 130_000
  }.freeze

  PP_SUBSCRIPTION_CHARGES = {
    'one_year' => 15_000,
    'five_year' => 70_000,
    'ten_year' => 130_000
  }.freeze

  belongs_to :user
  before_validation :create_razorpay_order

  private

  def ss_or_pp_should_be_present
    return unless ss_subscription_period.blank? && pp_subscription_period.blank?

    errors.add(:ss_subscription_period, I18n.t('errors.razorpay_order.ss_or_pp_subscription_required'))
  end

  def create_razorpay_order
    return if order_id

    order = Razorpay::Order.create amount: create_amount, currency: 'INR'
    self.order_id = order.id
  end

  def create_amount
    amount = 0
    amount += SS_SUBSCRIPTION_CHARGES[ss_subscription_period] if ss_subscription_period
    amount += PP_SUBSCRIPTION_CHARGES[pp_subscription_period] if pp_subscription_period
    amount
  end
end
