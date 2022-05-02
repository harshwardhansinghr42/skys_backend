# frozen_string_literal: true

# Razorpay Orders
class RazorpayOrder < ApplicationRecord
  enum ss_subscription_period: Subscription::SS_SUBSCRIPTION.keys, _prefix: true
  enum pp_subscription_period: Subscription::PP_SUBSCRIPTION.keys, _prefix: true

  validates :order_id, :user_name, :user_address, :user_city,
            :user_state, :user_pincode, :user_phone, presence: true
  validate :ss_or_pp_should_be_present

  belongs_to :user
  has_many :payment_successes

  before_validation :create_razorpay_order

  # checkout amount = amount + 3% service tax
  def calculate_amount
    (create_amount + create_amount * 0.03).to_i
  end

  private

  def ss_or_pp_should_be_present
    return unless ss_subscription_period.blank? && pp_subscription_period.blank?

    errors.add(:ss_subscription_period, I18n.t('errors.razorpay_order.ss_or_pp_subscription_required'))
  end

  def create_razorpay_order
    return if order_id

    order = Razorpay::Order.create amount: calculate_amount, currency: 'INR'
    self.order_id = order.id
  end

  def create_amount
    amount = 0
    amount += Subscription::SS_SUBSCRIPTION[ss_subscription_period] if ss_subscription_period
    amount += Subscription::PP_SUBSCRIPTION[pp_subscription_period] if pp_subscription_period
    amount
  end
end
