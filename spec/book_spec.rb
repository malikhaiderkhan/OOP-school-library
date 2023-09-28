require_relative '../lib/book'
require_relative '../lib/person'
require_relative '../lib/rental'

RSpec.describe Book do
  describe '#initialize' do
    it 'creates a new book with title and author' do
      title = 'Subcontinent'
      author = 'Haider'

      book = Book.new(title, author)

      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
    end

    it 'initializes rentals as an empty array' do
      book = Book.new('Title', 'Author')

      expect(book.rentals).to be_an(Array)
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'adds a rental to the book' do
      book = Book.new('Subcontinent', 'Haider')
      person = Person.new(26, 'David')

      rental = book.add_rental(person, '2023-09-28')

      expect(book.rentals).to include(rental)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end
end
