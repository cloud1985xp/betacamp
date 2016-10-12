class Provider < ApplicationRecord
  has_many :products, dependent: :destroy
end
