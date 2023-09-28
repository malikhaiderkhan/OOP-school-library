require_relative '../lib/rental'
require_relative '../lib/book'
require_relative '../lib/person'

RSpec.describe Rental do
  describe '#initialize' do
    it 'creates a rental' do
      book = Book.new('Subcontinent', 'Haider')
      person = Person.new(26, 'David')

      rental = Rental.new('2023-09-28', book, person)

      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end
end