require_relative 'Player'
require_relative 'Board'

class Game
  attr_accessor :winner, :players, :board

  def initialize
    @board = Board.new
    @players = [Player.new('Player1', 'x'),
                Player.new('Player2', 'o')]
    @winner = nil
  end

  private

  def play_round(player)
    puts "#{player.name}'s turn"
    print 'Please put the position you want to mark (0-8): '
    while true
      position = gets.to_i
      if board.valid?(position)
        break
      else
        print 'Invalid choice, either not empty or not in range, please try again: '
      end
    end
    board.mark(position, player.symbol)
    board.print_board
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
    until board.isFull?
      current_player = players[current_player_idx]
      play_round(current_player)
      # stop if player won
      # break unless winner.nil?
      if board.matched?
        annouceWinner(current_player)
        break
      end
      if board.isFull?
        puts 'No one won this match'
        break
      end
      current_player_idx = (current_player_idx + 1) % 2
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
