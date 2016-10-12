class AddProductsProviderId < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :provider_id, :integer
    add_index :products, :provider_id
  end
end
