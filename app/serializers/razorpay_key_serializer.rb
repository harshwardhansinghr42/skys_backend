# frozen_string_literal: true

# razorpay key serializer
class RazorpayKeySerializer < ActiveModel::Serializer
  attributes :api_key

  def api_key
    'rzp_test_wRJlLSU8I37GQu'
  end
end
