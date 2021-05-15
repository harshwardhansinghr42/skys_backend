class RazorpayOrders < ActiveRecord::Migration[6.1]
  def change
  	create_table :razorpay_orders do |t|
      t.string :order_id, null: false
      t.integer :ss_subscription_plan
      t.integer :pp_subscription_plan
      t.string :user_name, null: false
      t.string :user_address, null: false
      t.string :user_city, null: false
      t.string :user_state, null: false
      t.string :user_pincode, null: false
      t.string :user_phone, null: false
      t.references :user
      
      t.timestamps
    end

    add_index :razorpay_orders, :order_id, unique: true
    add_index :razorpay_orders, :user_name
    add_index :razorpay_orders, :user_phone
  end
end
