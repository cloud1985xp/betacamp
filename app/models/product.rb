class Product < ApplicationRecord
  belongs_to :category
  validates_presence_of :name, :price

  def to_param
    "#{id}-#{friendly_id}"
  end
end
