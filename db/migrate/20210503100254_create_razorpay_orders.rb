class CreateRazorpayOrders < ActiveRecord::Migration[6.1]
  def change
  	create_table :razorpay_orders do |t|
      t.string :order_id, null: false
      t.integer :ss_subscription_period
      t.integer :pp_subscription_period
      t.string :user_name
      t.string :user_address
      t.string :user_city
      t.string :user_state
      t.string :user_pincode
      t.string :user_phone
      t.references :user
      
      t.timestamps
    end

    add_index :razorpay_orders, :order_id, unique: true
    add_index :razorpay_orders, :user_name
    add_index :razorpay_orders, :user_phone
  end
end
