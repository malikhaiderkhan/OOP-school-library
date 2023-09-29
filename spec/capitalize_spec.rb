require_relative '../lib/person'
require_relative '../lib/capitalize_decorator'

describe CapitalizeDecorator do
  before do
    @person = Person.new(94, 'Leornardo')
    @capitalize_person = CapitalizeDecorator.new(@person).correct_name
  end

  context 'Create an instance of capitalize and test functionality' do
    it 'should capitalize the first name' do
      expect(@capitalize_person).to eq 'Leornardo'
    end
  end
end