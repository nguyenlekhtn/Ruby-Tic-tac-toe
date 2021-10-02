require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  describe 'win conditions' do
    let(:game_win) { described_class.new(board: Board.new(board: board_array)) }

    before do
      allow(game_top_row).to receive(:introduction)
    end

    context "when board's top row match" do
      let(:board_array) { ['x', 'x', 'x', 'o', 'o', nil, nil, nil, nil] }

      it 'calls announce_winner' do
        expect(game_win).to receive(:announce_winner).once
        game_win.start_game
      end
    end

    context "when board's mid row match" do
      let(:board_array) { [nil, nil, nil, 'o', 'o', 'o', nil, nil, nil] }

      it 'calls announce_winner' do
        expect(game_win).to receive(:announce_winner).once
        game_win.start_game
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
end
