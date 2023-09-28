require_relative '../lib/person'
require_relative '../lib/book'
require_relative '../lib/rental'

RSpec.describe Person do
  describe '#initialize' do
    it 'creates a person with default values' do
      person = Person.new(25)
      
      expect(person.name).to eq('Unknown')
      expect(person.parent_permission).to be_truthy
      expect(person.age).to eq(25)
      expect(person.rentals).to be_empty
    end
    
    it 'creates a person with custom values' do
      person = Person.new(30, 'John Doe', parent_permission: false)
      
      expect(person.name).to eq('John Doe')
      expect(person.parent_permission).to be_falsy
      expect(person.age).to eq(30)
      expect(person.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    context 'when of age' do
      it 'can use services' do
        person = Person.new(18)
        
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when not of age with parent permission' do
      it 'can use services' do
        person = Person.new(16, 'Devendra', parent_permission: true)
        
        expect(person.can_use_services?).to be_truthy
      end
    end

    context 'when not of age without parent permission' do
      it 'cannot use services' do
        person = Person.new(16, 'Blue', parent_permission: false)
        
        expect(person.can_use_services?).to be_falsy
      end
    end
  end

  describe '#correct_name' do
    it 'returns the correct name' do
      person = Person.new(25, 'John Doe')
      
      expect(person.correct_name).to eq('John Doe')
    end
  end

  describe '#add_rental' do
    it 'creates a rental and adds it to the person' do
      person = Person.new(25, 'John Doe')
      book = Book.new('Hitman', 'Haider')
      
      rental = person.add_rental(book, '2023-09-28')
      
      expect(person.rentals).to include(rental)
      expect(rental.person).to eq(person)
    end
  end
end