class AddProductsFriendlyId < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :string, :friendly_id
  end
end
