require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  context 'when first row match' do
    it 'is game_over' do
      board = ['x', 'x', 'x', 'o', 'o', nil, 'o', nil, nil]
      game = Game.new(board: board)
      expect(game).to receive(:game_over?)
    end
  end
end
