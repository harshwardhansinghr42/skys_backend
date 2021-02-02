#frozen string literal

# user related controller operations
module Userable
  extend ActiveSupport::Concern

  # find or create user
  def request_user
    @request_user ||= begin
      user = User.find_by(email: registration_params[:email]) if registration_params[:email]
      user = User.find_by(phone: registration_params[:phone]) if !user && registration_params[:phone]
      user ||= User.create(registration_params)
      user
    end
  end

  def registration_params
		params.require(:user).permit(:email, :phone)
	end
end
