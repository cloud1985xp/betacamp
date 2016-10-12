class Payment < ApplicationRecord
  serialize :params, JSON
  belongs_to :order

  PAYMENT_METHODS = %w[Credit WebATM ATM] # CVS BARCODE
  BOOTCAMP_NO = 10

  validates_presence_of :order_id, :amount
  validates_inclusion_of :payment_method, :in => PAYMENT_METHODS
end
