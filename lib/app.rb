  def list_people
    puts 'List of People:'
    @people.each do |person|
      puts "[#{person.class}], ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end
