require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

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
        expect { game_switch.switch_active_player }.to change { game_switch.current_active_player_index }.from(0).to(1)
      end
    end

    context 'when current_active_player_index is 1' do
      subject(:game_switch) { described_class.new(current_active_player_index: 1) }

      it 'changes to 0' do
        expect { game_switch.switch_active_player }.to change { game_switch.current_active_player_index }.from(1).to(0)
      end
    end
  end

  describe '#player_input' do
    let(:player0) { instance_double(Player) }
    let(:player1) { instance_double(Player) }
    subject(:game_player) { described_class.new(players: [player0, player1]) }
    let(:condition) { instance_double(Proc) }


    before do
      allow(game_player).to receive(:current_active_player).and_return(player0)
      allow(game_player).to receive(:method).with(:verify_input).and_return(condition)
    end

    it 'sends :player_input to current_active_player' do
      expect(player0).to receive(:player_input).with(condition)
      game_player.player_input
    end
  end

  describe '#mark_board' do
    let(:board) { instance_double(Board) }
    subject(:game_mark) { described_class.new(board: board) }

    before do
      allow(game_mark).to receive(:current_active_player_symbol).and_return('x')
    end
    it 'send mark message to board with position from parameter and value from current_active_player_symbol' do
      expect(board).to receive(:mark).with(position: 0, value: 'x')
      game_mark.mark_board(0)
    end
  end

  describe '#current_active_player_symbol' do
    subject(:game_current) { described_class.new }
    let(:player) { instance_double(Player) }

    before do
      allow(game_current).to receive(:current_active_player).and_return(player)
    end

    it 'send symbol message to current_active_player' do
      expect(player).to receive(:symbol)
      game_current.current_active_player_symbol
    end
  end

  describe '#game_over?' do
    subject(:game_over) { described_class.new(board: board) }
    let(:board) { instance_double(Board) }

    context 'when board have any_line_match' do
      before do
        allow(board).to receive(:any_line_match?).and_return(true)
      end

      it 'is game over' do
        expect(game_over).to be_game_over
      end
    end

    context 'when board doesn\'t have any_line_match but board is full' do
      before do
        allow(board).to receive(:any_line_match?).and_return(false)
        allow(board).to receive(:full?).and_return(true)
      end

      it 'is game over' do
        expect(game_over).to be_game_over
      end
    end

    context 'when board neither have any_line_match nor full' do

      before do
        allow(board).to receive(:any_line_match?).and_return(false)
        allow(board).to receive(:full?).and_return(false)
      end

      it 'is not game over' do
        expect(game_over).not_to be_game_over
      end
    end
  end
end
