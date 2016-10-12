class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, foreign_key: 'item_id', dependent: :destroy
  # Product has many cart items, 依慣例 在 CartItem 上要用 product_id 做 foreign_key
  # 但因為我故意在 CartItem 上用 item_id 當名稱，所以這裡也要指明我要的 foreign_key 名稱

  has_many :carts, through: :cart_items
  validates_presence_of :name, :price

  scope :active, ->{ where(active: true).where('shelved_on <= ?', Date.current) }
end
