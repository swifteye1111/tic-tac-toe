# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  subject(:new_game) { described_class.new }

  describe '#play_round' do
    # test game end loop

    context 'when end_game? is false once' do

      before do
        allow(new_game).to receive(:end_game?).and_return(false, true)
        choice = 1
        player_one = new_game.instance_variable_get(:@player1)
        allow(new_game).to receive(:get_choice).with(player_one).and_return(choice)
        allow(new_game).to receive(:puts)
      end

      it 'calls update_board one time' do
        expect(new_game).to receive(:update_board).exactly(1).time
        new_game.play_round
      end
    end

    context 'when end_game? is false twice' do
    before do
      allow(new_game).to receive(:end_game?).and_return(false, false)
    end

      xit 'calls update_board two times' do
        expect(new_game).to receive(:update_board).exactly(2).times
        new_game.play_round
      end
    end
  end

  describe '#get_choice' do
  end

  describe '#update_board' do
  end

  describe '#update_win_check' do
  end

  describe '#end_game?' do
  end
end