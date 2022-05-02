# frozen_string_literal: true

# order created response serializer
class OrderListResponseSerializer < ActiveModel::Serializer
  attributes :order_name, :address, :created_at, :amount

  def order_name
    ApplicationHelper.admin_email_ss_pp_subscriptions(object)
  end

  def address
    "#{object.user_address}, #{object.user_city}, #{object.user_state}(#{object.user_pincode})"
  end

  def created_at
    object.created_at.strftime("%b %-d, %Y")
  end

  def amount
    "Rs #{object.calculate_amount/100}/-"
  end
end