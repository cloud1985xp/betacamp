class OrderChangeRecord < ApplicationRecord
  belongs_to :order
  serialize :values
end
