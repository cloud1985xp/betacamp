class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :item_id, null: false
      t.integer :cart_id, null: false
      t.integer :quantity, default: 0, null: false
      t.timestamps
    end

    add_index :cart_items, :item_id
    add_index :cart_items, :cart_id
  end
end
