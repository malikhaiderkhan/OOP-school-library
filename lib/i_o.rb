require 'json'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'book'
require_relative 'person'
require 'pry'
class IOFILE
  def file_exist?(name)
    File.exist?(name) && File.size(name).positive?
  end

  def from_json(name)
    object_container = []
    if file_exist?(name)
      JSON.parse(File.read(name)).each do |element|
      if name == 'people.json'

        # binding.pry
        object_container << if element['type'] == 'Student'
                              Student.new(element['age'], element['name'], element['parent_permission'])
                            else
                              Teacher.new(element['age'], element['specialization'], element['name'])
                            end
      elsif name == 'rentals.json'
        book = Book.new(element['book'].title, element['book'].author)
        person = Person.new(element['person'].id, element['person'].name, element['person'].age, element['person'].parent_permission)
        object_container << Rental.new(element['date'], book, person)
      end
    end
    object_container
  end

  def from_rentals(rentals)
    rentals_data = []
    rentals.each do |element|
      rentals_data.push({ date: element.date, book: element.book })
    end
    rentals_data
  end

  def to_json(data_container, name)
    data_stream_object_container = []
    File.open(name, 'w') do |file|
      data_container.each do |element|
      if name == 'people.json'

        rentals_data_stream = from_rentals(element.rentals)
        if element.is_a?(Student)
          data_stream_object_container.push({ type: 'Student', age: element.age, name: element.name,
                                              parent_permission: element.parent_permission,
                                              rentals: rentals_data_stream })
        else
          data_stream_object_container.push({ type: 'Teacher', age: element.age, specialization: element.specialization,
                                              name: element.name, rentals: rentals_data_stream })
        end
      elsif name == 'rentals.json'
        book = { element.book.author, element.book.title }
        person = { element.person.id, element.person.name, element.person.age, element.person.parent_permission }
        data_stream_object_container.push({ date:element.date, book:book, person:person })
      end
      file.write(data_stream_object_container.to_json)
    end
  end
end
