# frozen_string_literal: true

class Board
  CONDITIONS = [
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize(board: Array.new(size))
    @board = board
  end

  def size
    9
  end

  def mark(position:, value:)
    board[position] = value
  end

  def cell(position)
    board[position]
  end

  # def valid_coord(row, col)
  #   row.match(/^\d+$/) && col.match(/^\d+$/) && in_range(row: row, col: col)
  # end

  def same_symbol?(positions)
    positions.all? { |position| cell(position) && cell(position) == cell(positions[0]) }
  end

  def any_line_match?
    CONDITIONS.any? { |condition| same_symbol?(condition) }
  end

  def print_board
    puts board_string(board)
  end

  def in_range?(position)
    position.between?(0, size - 1)
  end

  def available?(position)
    cell(position).nil?
  end

  def full?
    board.select(&:nil?).empty?
  end

  private

  attr_accessor :board

  def line(*cell_values)
    cell_values.map { |cell_value| cell_value || ' ' }.join(' | ')
  end

  def line_seperator
    <<~MSG

      ---------
    MSG
  end

  def board_string(board, string = '')
    return string if board.empty?

    a, b, c, *rest = board
    seperator = board.length == 3 ? "\n" : line_seperator
    string = string + line(a, b, c) + seperator
    board_string(rest, string)
  end
end
