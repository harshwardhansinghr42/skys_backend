# frozen_string_literal: true

# Random Generator
class GenericHelpers
  def self.otp
    rand(100000...999999)
  end
end