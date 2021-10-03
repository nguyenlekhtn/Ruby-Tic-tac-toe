# frozen_string_literal: true

class Player
  attr_reader :symbol, :game

  def initialize(symbol, game)
    @symbol = symbol
    @game = game
  end

  def player_input
    loop do
      player_input = gets.chomp
      verified_input = verify_input(player_input.to_i) if player_input.match?(/^\d+$/)

      return verified_input if verified_input

      puts 'Invalid choice, please type again'
    end
  end

  def verify_input(input)
    return input if game.input_valid?(input)
  end
end
