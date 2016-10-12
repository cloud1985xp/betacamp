class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :change_records, class_name: 'OrderChangeRecord', dependent: :destroy
  has_many :payments, dependent: :destroy

  validates_presence_of :name, :email, :amount
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank

  after_save :record_changes

  def calculate_amount
    self.amount = order_items.sum(&:subtotal)
    self.save!
  end

  private

  def record_changes
    change_records.create(values: changes) if changed?
  end
end
