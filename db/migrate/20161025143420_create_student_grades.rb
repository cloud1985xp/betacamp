class CreateStudentGrades < ActiveRecord::Migration[5.0]
  def change
    create_table :student_grades do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.string :grade
      t.integer :score
      t.timestamps
    end

    add_index :student_grades, :student_id
    add_index :student_grades, :course_id
    add_index :student_grades, [:course_id, :grade]
    add_index :student_grades, [:student_id, :grade]
  end
end
