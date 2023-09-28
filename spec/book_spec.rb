require_relative '../lib/book'
require_relative '../lib/person'
require_relative '../lib/rental'

RSpec.describe Book do
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