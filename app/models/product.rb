class Product < ApplicationRecord
  belongs_to :category
  validates_presence_of :name, :price

  scope :active, ->{ where(active: true) }
end
