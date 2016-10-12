class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :type
      t.string :name
      t.string :contact
      t.string :telephone
      t.string :country
      t.string :state
      t.string :city
      t.string :street
      t.string :zip_code
      t.timestamps
    end
  end
end
