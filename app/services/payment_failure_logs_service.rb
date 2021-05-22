# frozen_string_literal: true

# payment failure logs
class PaymentFailureLogsService
  def initialize(error_generic_msg, error_data)
    @error_generic_msg = error_generic_msg
    @error_data = error_data
    @payment_failure_logger ||= Logger.new("#{Rails.root}/log/payment_failure.log")
  end

  def call
    @payment_failure_logger.error("\n START \n #{@error_generic_msg} \n #{@error_data.inspect} \n END \n")
  end
end
