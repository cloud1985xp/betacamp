class AddProductsShelvedOn < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :shelved_on, :date
    add_index :products, [:category_id, :active, :shelved_on]

    Product.where(active: true).update_all(shelved_on: Date.current)
  end
end
