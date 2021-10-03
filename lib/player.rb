# frozen_string_literal: true

class Player
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def player_input(condition_lambda)
    loop do
      player_input = gets.chomp
      if player_input.match(/^\d+$/)
        verified_input = verify_input(input: player_input.to_i, condition: condition_lambda)
      end

      return verified_input if verified_input

      puts 'Invalid choice, please type again'
    end
  end

  private def verify_input(input:, condition:)
    return input if condition.call(input) == true
  end
end
