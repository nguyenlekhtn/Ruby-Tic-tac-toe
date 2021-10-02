# frozen_string_literal: true

require 'pry-byebug'

require_relative 'board'
require_relative 'player'

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
    check_end_case
  end

  private

  attr_accessor :current_active_player_index
  attr_reader :board, :players

  def check_end_case
    if board.any_line_match?
      announce_tie
    else
      announce_winner
    end
  end

  def switch_active_player
    self.current_active_player_index = current_active_player_index.zero? ? 1 : 0
  end

  def verify_input(player_input)
    board.in_range?(player_input) && board.available?(player_input)
  end


  def play_round
    switch_active_player
    print_board
    round_introduction
    position = player_input
    mark_board(position)
  end

  def round_introduction
    puts <<~MSG
      Player #{current_active_player_index}'s turn
      Please type the number of cell you want to mark:
    MSG
  end

  def print_board
    board.print_board
  end

  def player_input
    condition_lambda = method(:verify_input)
    current_active_player.player_input(condition_lambda)
  end

  def available_choice
    board.available_positions
  end

  def current_active_player
    players[current_active_player_index]
  end

  def mark_board(position)
    board.mark(position: position, value: current_active_player.symbol)
  end

  def announce_tie
    puts 'Board is full. No one won'
  end

  def announce_winner
    puts "Player #{current_active_player_index} won."
  end

  def game_over?
    board.any_line_match? || board.full?
  end

  def introduction
    puts <<~MSG
      Welcome to tic-tac-toe game
    MSG
  end
end
