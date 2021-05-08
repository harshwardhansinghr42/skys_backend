class RazorpayOrders < ActiveRecord::Migration[6.1]
  def change
  	create_table :razorpay_orders do |t|
      t.string :name, null: false
      t.string :order_id, null: false
      
      t.timestamps
    end
  end
end
