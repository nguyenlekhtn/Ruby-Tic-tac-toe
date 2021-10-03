require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Player do

  subject(:player) { described_class.new('x', game) }

  describe '#player_input' do
    let(:game) { instance_double(Game) }
    let(:input) { double('input',:to_i => input_number, :match? => true) }
    let(:input_number) { double('input number')}

    before do
      allow(player).to receive(:gets).and_return(input)
      allow(input).to receive(:chomp).and_return(input)
      allow(player).to receive(:puts)

    end

    context 'when input verified' do
      before do
        allow(player).to receive(:verify_input).with(input_number).and_return(input_number)
      end

      it 'stop loop and not give any error messages' do
        expect(game).to_not receive(:puts)
        player.player_input
      end
    end

    context 'when input not satisfies given condition, then does' do

      before do
        allow(player).to receive(:verify_input).with(input_number).and_return(false, input_number)
      end

      it 'complete loop and display error messange once' do
        expect(player).to receive(:puts).once
        player.player_input
      end
    end
  end
end