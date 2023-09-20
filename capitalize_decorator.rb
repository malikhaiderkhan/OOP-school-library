require "./base_decorator.rb"

class CapitalizeDecorator < BaseDecorator
    def correct_name
        @nameable.correct_name.capitalize
    end
end