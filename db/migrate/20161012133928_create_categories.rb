class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position
      t.string :description
      t.boolean :enabled, default: true
      t.timestamps
    end

    add_index :categories, [:enabled, :position]
  end
end
