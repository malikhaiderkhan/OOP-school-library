require_relative '../lib/base_decorator'

RSpec.describe BaseDecorator do
  describe '#correct_name' do
    it 'returns the correct name' do
      decorated_object = double('Decorated object')
      allow(decorated_object).to receive(:correct_name).and_return('Haider')

      decorator = BaseDecorator.new(decorated_object)
      result = decorator.correct_name

      expect(result).to eq('Haider')
    end
  end
end
