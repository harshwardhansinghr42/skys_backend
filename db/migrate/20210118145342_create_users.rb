class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :phone, null: true
      t.string :email, null: true
      t.string :name
      t.string :otp
      t.datetime :otp_created_at
      t.datetime :otp_confirmed_at

      t.timestamps
    end

    add_index :users, :phone, unique: true
    add_index :users, :email, unique: true
    add_index :users, :name
  end
end
