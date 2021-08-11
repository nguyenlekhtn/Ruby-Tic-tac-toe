# frozen_string_literal: true

require_relative "tic_tac_toe/version"


module TicTacToe
  


  class Error < StandardError; end
  # Your code goes here...

  class Cell
    attr_accessor :value
    def initialize(value='')
      self.value = value
    end
  end

  class Board
    CONDITIONS = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    SIZE = 9
    DEFAULT_VALUE = ''

    attr_reader :board

    def initialize
      @board = Array.new(9) {Cell.new(DEFAULT_VALUE)}  
    end

    def mark(position, symbol)
      self.set_value(position, symbol);
    end

    def valid?(position)
      value = self.board[position].value
      value == DEFAULT_VALUE && value.to_i.between?(0, SIZE - 1)
    end

    def print_board
      0.upto(2) do |i|
        (i*3).upto(i*3+2) do |j|
          value = self.board[j].value == '' ? '.' : self.board[j].value;
          print value + ' '
        end
        print "\n";
      end
    end

    def is_3_equal?(idx_arr)
      a, b, c = idx_arr.map {|idx| self.board[idx].value}
      if(a == b && a == c && a != DEFAULT_VALUE)
        result = true
      else
        result = false
      end
      puts ""
      result
    end

    def matched?
      result = CONDITIONS.any? {|condition| is_3_equal?(condition)}
      result
    end

    def set_value(position, value)
      if(position.between?(0, SIZE))
        @board[position].value = value;
      else
        raise "INVALID POSITION"
      end
    end

    def isFull?
      if self.board.all? {|cell| cell.value != DEFAULT_VALUE}
        return true
      else
        return false
      end
    end
  end

  class Game

    attr_accessor :winner, :players, :board;
    def initialize
      @board = Board.new();
      @players = [Player.new('Player1', 'x'),
                  Player.new('Player2', 'o')];
      @winner = nil
    end

    private
    def play_round(player)
      puts "#{player.name}'s turn"
      print "Please put the position you want to mark (0-8): "
      while true do
        position = gets.to_i
        if self.board.valid?(position)
          break
        else
          print "Invalid choice, either not empty or not in range, please try again: "
        end
      end
      self.board.mark(position, player.symbol)
      self.board.print_board
      # if(self.board.isMatched?)
      #   self.winner = player
      # end
    end

    def annouceWinner(winner)
      puts "#{winner.name} has won the game"
    end

    public
    def start_game
      current_player_idx = 0
      until self.board.isFull? do
        current_player = self.players[current_player_idx];
        play_round(current_player)
        # stop if player won
        # break unless winner.nil?
        if(self.board.matched?)
          annouceWinner(current_player);
          break
        end
        if(self.board.isFull?)
          puts "No one won this match"
          break
        end
        current_player_idx  = (current_player_idx + 1) % 2
      end

      # unless winner.nil?
      #   annouceWinner(current_player)
      #   return
      # elsif self.board.isFull?
      #   puts "2 players draw"
      # else
        
      # end
    end
  end


  class Player
    attr_accessor :name, :symbol
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end

    def winner_msg
      `#{self.name} has won the game`
    end


  end
end

while true do
  new_game = TicTacToe::Game.new
  new_game.start_game
  print "New game?(Y/N): "
  answer = gets.chomp
  unless answer.match(/[Y]/i)
    break;
  end
end