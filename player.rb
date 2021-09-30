class Player
  attr_reader :symbol
  def initialize(symbol:, game:)
    @symbol = symbol
    @game = game
  end

  def player_input(avaiable_choice)
    loop do
      player_input = gets.chomp
      verified_input = verify_input(player_input.to_i, avaiable_choice)
      return verified_input if verified_input

      puts "Invalid choice, please type again"
    end
  end

  def verify_input(player_input, avaiable_choice)
    return player_input if avaiable_choice.include?
  end
end