module Api
	module V1
		class ApplicationController < ActionController::API
			def error_messages(errors_arr)
				errors.full_messages.join(', ')
			end
		end
	end
end