class CreatePaymentSuccesses < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_successes do |t|
      t.string :razorpay_payment_id
      t.string :razorpay_signature
      t.boolean :signature_verified, default: false
      t.references :razorpay_order
      
      t.timestamps
    end
  end
end
