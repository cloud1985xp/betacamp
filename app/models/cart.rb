class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def empty?
    cart_items.empty?
  end

  def add_item(product)
    cart_item = cart_items.where(item: product).first_or_initialize
    cart_item.increment(:quantity)
    save && cart_item.save
  end

  def total
    cart_items.sum(&:subtotal)
  end
end
