class Game
  def initialize(board: Board.new,
                 current_active_player_index: 0,
                 players: [Player.new(symbol: 'x', game: self), Player.new(symbol: 'o', game: self)])
    @board = board
    @current_active_player_index = current_active_player_index
    @players = players
  end

  def start_game
    introduction
    play_round until game_over?
    annouce_winner
  end

  private
  attr_accessor :current_active_player_index

  def switch_active_player
    current_active_player_index = current_active_player_index == 0 ? 1 : 0
  end

  def play_rounds
    switch_active_player
    puts "Player #{current_active_player_index}'s turn"
    position = current_active_player.player_input(available_choice)
    mark_board(position)
  end

  def avaiable_choice
    board.avaiable_positions
  end

  def current_active_player
    players[current_active_player_index]
  end

  def mark_board(position)
    board.mark(position: position, mark: current_active_player.symbol)
  end

  

  def annouce_winner
    puts "Player #{current_active_player_index} won."
  end
end
