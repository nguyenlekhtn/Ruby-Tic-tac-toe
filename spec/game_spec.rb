require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  describe 'win conditions' do
    let(:game_win) { described_class.new(board: Board.new(board: board_array)) }

    context 'when a row match' do
      let(:board_array) { ['x', 'x', 'x', 'o', 'o', nil, nil, nil, nil] }

      it 'is game over' do
        expect(game_win).to be_game_over
      end
    end

    context 'when a column match' do
      let(:board_array) { ['x', 'x', 'o', 'x', 'o', 'o', 'x', nil, nil] }

      it 'is game over' do
        expect(game_win).to be_game_over
      end
    end

    context 'when a cross match' do
      let(:board_array) { ['o', 'x', 'x', 'x', 'o', 'o', 'x', nil, 'o'] }

      it 'is game over' do
        expect(game_win).to be_game_over
      end
    end

    context 'no line match' do
      let(:board_array) { ['x', 'x', 'o', 'x', 'o', 'o', nil, 'x', nil] }

      it 'is not game over' do
        expect(game_win).to_not be_game_over
      end
    end
  end

  describe '#start_game' do
    let(:board) { instance_double(Board) }
    let(:game_start) { described_class.new(board: board) }

    before do
      allow(game_start).to receive(:introduction)
      allow(game_start).to receive(:play_round)
      allow(game_start).to receive(:check_end_case)
    end

    context 'when game_over? false once' do
      before do
        allow(game_start).to receive(:game_over?).and_return(false, true)
      end

      it 'calls game_start once' do
        expect(game_start).to receive(:play_round).once
        game_start.start_game
      end
    end

    context 'when game_over? false twice' do
      before do
        allow(game_start).to receive(:game_over?).and_return(false, false, true)
      end

      it 'calls game_start twice' do
        expect(game_start).to receive(:play_round).twice
        game_start.start_game
      end
    end
  end

  describe '#check_end_case' do
    context 'when board.any_line_match? returns true' do
      let(:board) { instance_double(Board) }
      subject(:game_check) { described_class.new(board: board) }

      before do
        allow(board).to receive(:any_line_match?).and_return(true)
      end

      it 'calls announce_winner' do
        expect(game_check).to receive(:announce_winner).once
        game_check.check_end_case
      end
    end

    context 'when board.any_line_match? returns false' do
      let(:board) { instance_double(Board) }
      subject(:game_check) { described_class.new(board: board) }

      before do
        allow(board).to receive(:any_line_match?).and_return(false)
      end

      it 'calls announce_tie' do
        expect(game_check).to receive(:announce_tie).once
        game_check.check_end_case
      end
    end
  end

  describe '#switch_active_player' do
    context 'when current_active_player_index is 0' do
      subject(:game_switch) { described_class.new(current_active_player_index: 0) }

      it 'changes to 1' do
        expect { game_switch.switch_active_player }.to change { }
      end
    end
  end
end
