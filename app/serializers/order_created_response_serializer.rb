# frozen_string_literal: true

# order created response serializer
class OrderCreatedResponseSerializer < RazorpayKeySerializer
  belongs_to :user
  attributes :order_id, :user_name, :user_phone, :amount

  def amount
    object.calculate_amount
  end
end
