class StudentGrade < ApplicationRecord
  belongs_to :student
  belongs_to :course
end
