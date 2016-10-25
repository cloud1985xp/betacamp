class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def example
    @students = Student.all
    @courses = Course.all
    @sjg = Student.joins(:grades)
    @sjg2 = Student.select('students.*, student_grades.*').joins(:grades)

    @ljd = Student.select('students.*, student_grades.*').joins("LEFT JOIN student_grades ON students.id = student_grades.student_id")
    @ljd2 = Student.select('students.*, student_grades.*').joins("LEFT JOIN student_grades ON students.id = student_grades.student_id").where('score > 75')

    @grade_condition_value = params[:grade] || 'B'
    @level_condition_value = params[:level] || 3
    @score_condition_value = params[:score] || 95

    @cjd = Student.select('students.*, student_grades.*').joins(:grades).where('student_grades.grade = ?', @grade_condition_value)
    @data = Student.includes(:grades).where(student_grades: { grade: @grade_condition_value })

    @m2m1 = Student.joins(:courses).where('courses.level = ?', @level_condition_value)
    @m2m2 = Student.includes(:courses).where(courses: { level: @level_condition_value })

    @dist = Student.joins(:grades).where('student_grades.score > ?', @score_condition_value).distinct
  end
end
