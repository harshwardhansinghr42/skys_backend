namespace :razorpay_orders do
  desc "Create razorpay orders"
  task :create => :environment do
  	begin
  		return if RazorpayOrder.count > 0
  		
	  	order_1 = Razorpay::Order.create amount: 150, currency: 'INR', receipt: 'SS_ONE_YEAR'
	  	order_2 = Razorpay::Order.create amount: 700, currency: 'INR', receipt: 'SS_FIVE_YEAR'
	  	order_3 = Razorpay::Order.create amount: 1300, currency: 'INR', receipt: 'SS_TEN_YEAR'

	  	order_4 = Razorpay::Order.create amount: 150, currency: 'INR', receipt: 'PP_ONE_YEAR'
	  	order_5 = Razorpay::Order.create amount: 700, currency: 'INR', receipt: 'PP_FIVE_YEAR'
	  	order_6 = Razorpay::Order.create amount: 1300, currency: 'INR', receipt: 'PP_TEN_YEAR'

	  	for i in 1..6 do
	  		RazorpayOrder.create(name: eval("order_#{i}.receipt"), order_id: eval("order_#{i}.id"))
	  	end
	  rescue StandardError => error
  		Rails.logger.debug("<<<<<<< Creating razorpay orders error -- #{error.message} >>>>>>>>>")
  	end
  end
end