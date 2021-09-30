class Board
  attr_reader :board
  def initialize
    @board = Array.new(9)
  end

  def mark(position:, marker:)
    return unless in_range?(position)

    board[position] = marker
  end
  if in_range?(position)

  def size
    9
  end

  private
  attr_writer :board

  def in_range?(position)
    position.between(0...size)
  end
end