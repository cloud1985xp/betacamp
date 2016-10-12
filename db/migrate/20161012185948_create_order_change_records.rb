class CreateOrderChangeRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :order_change_records do |t|
      t.integer :order_id
      t.text :values
      t.timestamps
    end

    add_index :order_change_records, :order_id
  end
end
