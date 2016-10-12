class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  validates_presence_of :name, :email, :amount
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank

  def calculate_amount
    self.amount = order_items.sum(&:subtotal)
    self.save!
  end
end
