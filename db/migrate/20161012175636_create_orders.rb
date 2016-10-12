class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :amount, null: false
      t.string :email, null: false
      t.string :name
      t.string :mobile
      t.boolean :paid, default: false
      t.timestamps
    end

    add_index :orders, :user_id
  end
end
