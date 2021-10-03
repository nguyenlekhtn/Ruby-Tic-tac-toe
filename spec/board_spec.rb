require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new(board: board_arr) }

  describe '#same_symbol?' do
    let(:board_arr) { ['x', 'x', 'x', 'o', 'x', 'o', 'o', nil, nil] }

    context 'when 3 squares not match' do
      it 'return false' do
        positions = [3, 4, 5]
        result = board.same_symbol?(positions)
        expect(result).to eq(false)
      end
    end

    context 'when 3 squares match' do
      it 'return true' do
        positions = [0, 1, 2]
        result = board.same_symbol?(positions)
        expect(result).to eq(true)
      end
    end
  end

  describe '#any_line_match?' do
    context 'if a line is matched' do
      let(:board_arr) { ['x', 'x', 'x', 'o', 'x', 'o', 'o', nil, nil] }

      it 'returns true' do
        expect(board).to be_any_line_match
      end
    end

    context 'if no line is matched' do
      let(:board_arr) { ['x', 'o', 'x', 'o', 'x', 'o', 'o', nil, nil] }

      it 'returns false' do
        expect(board).not_to be_any_line_match
      end
    end
  end
end