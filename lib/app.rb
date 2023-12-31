require 'json'
require_relative 'book'
require_relative 'classroom'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'i_o'
require 'pry'

class App < IOFILE
  def initialize
    super()
    @books = []
    if File.exist?('books.json') && File.size('books.json').positive?
      JSON.parse(File.read('books.json')).each do |book|
        @books << Book.new(book['title'], book['author'])
      end
    end
    @people = from_json('people.json')
    @rentals = from_json('rentals.json')
  end

  def list_books
    puts 'List of Books:'
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      puts "[#{person.class}], ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    number = gets.chomp.to_i
    case number
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid choice.'
    end
  end

  def create_student
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Has parent permission? [Y/N]: '
    has_parent_permission = gets.chomp.downcase == 'y'
    person = Student.new(age, has_parent_permission, name)
    @people.push(person)
    puts 'Student created successfully.'
  end

  def create_teacher
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name)
    @people.push(person)
    puts 'Teacher created successfully.'
  end

  def create_book
    print 'Title:'
    title = gets.chomp
    print 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully.'
  end

  def create_rental
    display_books
    book_index = select_book
    if book_index.nil?
      puts 'Invalid book selection.'
      return
    end
    display_people
    person_index = select_person
    if person_index.nil?
      puts 'Invalid person selection.'
      return
    end
    book = @books[book_index]
    person = @people[person_index]
    print 'Enter rental date: '
    date = gets.chomp
    rental = Rental.new(date, book, person)
    @rentals.push(rental)
    puts 'Rental created successfully.'
  end

  def list_rentals_for_person
    puts 'Enter person ID to list rentals:'
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }
    if person
      puts "Rentals for #{person.name}:"
      person.rentals.each { |rental| puts "Book: #{rental.book.title} by #{rental.book.author}, Date: #{rental.date}" }
    else
      puts 'Person not found.'
    end
  end

  def save_to_file
    to_json(@people, 'people.json')
    to_json(@rentals, 'rentals.json')
    puts @people
    books = []
    File.open('books.json', 'w') do |file|
      @books.each do |book|
        bk = { title: book.title, author: book.author }
        books.push(bk)
      end
      file.write(books.to_json)
    end
  end

  private

  def display_books
    puts 'List of Books:'
    @books.each_with_index { |book, index| puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}" }
  end

  def select_book
    print 'Select a book (enter the number):'
    book_index = gets.chomp.to_i - 1
    (0...@books.length).include?(book_index) ? book_index : nil
  end

  def display_people
    puts 'List of People:'
    @people.each_with_index do |person, index|
      puts "#{index + 1}. ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end

  def select_person
    print 'Select a person (enter the number):'
    person_index = gets.chomp.to_i - 1
    (0...@people.length).include?(person_index) ? person_index : nil
  end
end
