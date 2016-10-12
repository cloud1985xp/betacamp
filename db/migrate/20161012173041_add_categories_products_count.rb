class AddCategoriesProductsCount < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :products_count, :integer, default: 0
  end
end
