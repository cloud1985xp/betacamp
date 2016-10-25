class Student < ApplicationRecord
  has_many :grades, class_name: 'StudentGrade', dependent: :destroy
  has_many :courses, through: :grades
  enum gender: %i(male female)
end
