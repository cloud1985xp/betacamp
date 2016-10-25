class Course < ApplicationRecord
  has_many :grades, class_name: 'StudentGrade', dependent: :destroy
  has_many :students, through: :grades
end
