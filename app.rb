require './book'
require './classroom'
require './person'
require './rental'
require './student'
require './teacher'

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
    @people.each { |person| puts "#{person.is_a?(Student) ? ' [Student]' : ' [Teacher]'} ID: #{person.id}, Name: #{person.name}, Age: #{person.age}" }
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [input the number]: '
    number = gets.chomp.to_i

    case number
    when 1
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Has parent permission? [Y/N]: '
    has_parent_permission = gets.chomp.downcase == 'y'
    person = Student.new(age, name, has_parent_permission)
    when 2
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    print 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name)
    else
      puts 'Invalid choice.'
      return
    end

    @people << person
    puts 'Person created successfully.'
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
    puts 'List of Books:'
    @books.each_with_index { |book, index| puts "#{index + 1}. Title: #{book.title}, Author: #{book.author}" }
    print 'Select a book (enter the number): '
    book_index = gets.chomp.to_i - 1
  
    if book_index >= 0 && book_index < @books.length
      book = @books[book_index]
      puts 'List of People:'
      @people.each_with_index { |person, index| puts "#{index + 1}. ID: #{person.id}, Name: #{person.name}, Age: #{person.age}" }
      print 'Select a person (enter the number): '
      person_index = gets.chomp.to_i - 1
  
      if person_index >= 0 && person_index < @people.length
        person = @people[person_index]
        print 'Enter rental date: '
        date = gets.chomp
  
        rental = Rental.new(date, book, person)
        @rentals << rental
        puts 'Rental created successfully.'
      else
        puts 'Invalid person selection.'
      end
    else
      puts 'Invalid book selection.'
    end
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
      puts ' '
      puts 'Please choose an option by entering a number:'
      puts '1. List all books'
      puts '2. List all people'
      puts '3. Create a person'
      puts '4. Create a book'
      puts '5. Create a rental'
      puts '6. List all rentals for a given person ID'
      puts '7. Quit'

      choice = gets.chomp.to_i

      case choice
      when 1
        list_books
      when 2
        list_people
      when 3
        create_person
      when 4
        create_book
      when 5
        create_rental
      when 6
        list_rentals_for_person
      when 7
        exit
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end
end

# Create an instance of the App class and run the application
app = App.new
app.run
