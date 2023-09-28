require_relative '../lib/teacher'

RSpec.describe Teacher do
  describe '#initialize' do
    it 'creates a teacher with default values' do
      teacher = Teacher.new(26, 'Ruby')

      expect(teacher.name).to eq('Unknown')
      expect(teacher.parent_permission).to be_truthy
      expect(teacher.age).to eq(26)
      expect(teacher.specialization).to eq('Ruby')
    end

    it 'creates a teacher with custom values' do
      teacher = Teacher.new(26, 'Ruby', 'John', parent_permission: true)

      expect(teacher.name).to eq('John')
      expect(teacher.parent_permission).to be_truthy
      expect(teacher.age).to eq(26)
      expect(teacher.specialization).to eq('Ruby')
    end
  end

  describe '#can_use_service?' do
    it 'can always use services' do
      teacher = Teacher.new(26, 'Ruby')

      expect(teacher.can_use_services?).to be_truthy
    end
  end
end
