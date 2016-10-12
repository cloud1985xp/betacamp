class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates_presence_of :quantity, :price

  def subtotal
    quantity * price
  end
end
