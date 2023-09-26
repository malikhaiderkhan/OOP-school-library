require_relative 'lib/app'
require 'json'

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

def menu_choice(choice, app)
  case choice
  when 1
    app.list_books
  when 2
    app.list_people
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.list_rentals_for_person
  else
    puts 'Invalid choice. Please try again.'
  end
end

def main
  app = App.new
  loop do
    display_menu
    choice = gets.chomp.to_i
    if choice == 7
      app.save_to_file
      exit
    else
      menu_choice(choice, app)
    end
  end
end

main
