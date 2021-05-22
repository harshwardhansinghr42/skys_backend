# frozen_string_literal: true

# Application Helper
module ApplicationHelper
  def admin_email_ss_pp_subscriptions(razorpay_order)
    str = ''
    if razorpay_order.ss_subscription_period
      str += "Sanghshakti #{razorpay_order.ss_subscription_period.titleize} Subscription"
    end
    if razorpay_order.pp_subscription_period
      str += ' and ' if str.present?
      str += "Pathprerak #{razorpay_order.pp_subscription_period.titleize} Subscription"
    end
    str
  end
end
