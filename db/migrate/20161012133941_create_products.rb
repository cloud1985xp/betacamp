class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :name
      t.string :description
      t.text :content
      t.integer :price
      t.boolean :active
      t.timestamps
    end

    add_index :products, :category_id
    add_index :products, [:category_id, :active]
  end
end
