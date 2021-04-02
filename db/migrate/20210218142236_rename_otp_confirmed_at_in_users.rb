class RenameOtpConfirmedAtInUsers < ActiveRecord::Migration[6.1]
  def change
  	rename_column :users, :otp_confirmed_at, :session_expired_at
  end
end
