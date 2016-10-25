namespace :example do
  task :data => :environment do
    Student.create!(name: 'John', gender: 'male', age: 19)
    Student.create!(name: 'Mary', gender: 'female', age: 22)
    Student.create!(name: 'Lee', gender: 'male', age: 21)
    Student.create!(name: 'Chen', gender: 'male', age: 20)
    Student.create!(name: 'Alice', gender: 'female', age: 18)
    Student.create!(name: 'Kevin', gender: 'male', age: 20)
    Student.create!(name: 'Cherry', gender: 'female', age: 24)

    courses = %w(
      History Mathematics
      Physics Science Literature).map do |subject|
      Course.create!(subject: subject, level: rand(1..3))
    end

    grades = %w(F E D C B A)

    courses_size = courses.size
    Student.find_each do |student|
      n = rand(2..courses_size.pred)
      Course.order('random()').limit(n).each do |course|
        score = rand(50..100)
        j = (score/10).round - 5
        grade = grades[j]
        student.grades.create(course: course, score: score, grade: grade)
      end
    end
    Student.create!(name: 'Luke', gender: 'male', age: 19)
  end
end