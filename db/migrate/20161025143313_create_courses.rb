class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :subject, null: false
      t.integer :level, null: false
      t.timestamps
    end
  end
end
