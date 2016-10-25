class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.timestamps
    end

    add_index :students, :age
    add_index :students, :gender
  end
end
