require_relative 'book'
require_relative 'classroom'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
CHOICES = {
  1 => :list_books,
  2 => :list_people,
  3 => :create_person,
  4 => :create_book,
  5 => :create_rental,
  6 => :list_rentals_for_person
}.freeze
class App
  def initialize
    @books = []
    @people = []
    @rentals = []
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
    person = Student.new(age, name, parent_permission: has_parent_permission)
    @people << person
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
    @people << person
    puts 'Teacher created successfully.'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
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
    @rentals << rental
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

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      exit if choice == 7
      if CHOICES.key?(choice)
        send(CHOICES[choice])
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end

  private

  def display_menu
    puts ' '
    puts 'Please choose an option by entering a number:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person ID'
    puts '7. Quit'
  end

  def display_books
    puts 'List of Books:'
    @books.each_with_index { |book, index| puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}" }
  end

  def select_book
    print 'Select a book (enter the number): '
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
    print 'Select a person (enter the number): '
    person_index = gets.chomp.to_i - 1
    (0...@people.length).include?(person_index) ? person_index : nil
  end
end
