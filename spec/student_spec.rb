require_relative '../lib/classroom'
require_relative '../lib/student'

describe Student do
  context 'Testing the functionality of class Student' do
    it 'Should create an instance of Student' do
      student = Student.new(78, 'buckmister', true)
      expect(student).to be_a Student
    end

    it 'Set the classroom' do
      student = Student.new(78, 'buckmister', true)
      my_classroom = Classroom.new('Project Management')
      student.classroom = student.classroom = (my_classroom)
      expect(my_classroom).to be_a Classroom
      expect(student.classroom.label).to eq 'Project Management'
    end

    it 'Should return an emoji' do
      student = Student.new(78, 'buckmister', true)
      expect(student.play_hooky).to eq '¯\(ツ)/¯'
    end
  end
end