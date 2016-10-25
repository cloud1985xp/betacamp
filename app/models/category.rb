class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :comments, as: :commentable
  validates_presence_of :name

  # 使用 acts_as_list 這個 gem，若沒裝記得去改 gemfile
  acts_as_list scope: :parent

  scope :enabled, ->{ where(enabled: true) }
  scope :root, ->{ where(parent_id: nil) }
end
