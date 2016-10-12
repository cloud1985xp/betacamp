class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category'
  validates_presence_of :name
  acts_as_list scope: :parent

  scope :enabled, ->{ where(enabled: true) }
  scope :root, ->{ where(parent_id: nil) }
end
