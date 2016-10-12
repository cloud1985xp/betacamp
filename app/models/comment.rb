class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates_presence_of :name, :content
end
