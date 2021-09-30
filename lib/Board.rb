class Board
  attr_reader :width

  def initialize
    @width  = 3
    @board = Array.new(width) { Array.new(width) }
  end

  def mark(row, col)
    raise "Invalid coord" unless valid_coord(row, col)

    board[row][col] = marker
  end

  def valid_coord(row, col)
    row.match(/^\d+$/) && col.match(/^\d+$/) && in_range(row: row, col: col)
  end

  def same_symbol?(*positions)
    positions.all { |position| board[position] && board[position] == board[0]}
  end

  def avaiable_positions
    board.select { |position| position.nil? }
  endchoice

  def any_line_match?
    CONDITIONS = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    CONDITIONS.any? { |condition| same_symbol?(condition) }
  end


  private
  
  attr_accessor :board

  def in_range?(row, col)
    row.between(0, width - 1) && column.between(0, width - 1)
  end
end