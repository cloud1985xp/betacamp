class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates_presence_of :name
  acts_as_list

  scope :enabled, ->{ where(enabled: true) }
end
