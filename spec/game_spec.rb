# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  describe '#play_round' do
    subject(:new_game) { described_class.new }

    context 'when end_game? is false once' do
      before do
        allow(new_game).to receive(:end_game?).and_return(false, true)
        choice = 1
        allow(new_game).to receive(:get_choice).and_return(choice)
        allow(new_game).to receive(:puts)
      end

      it 'calls update_board one time' do
        expect(new_game).to receive(:update_board).exactly(1).time
        new_game.play_round
      end
    end

    context 'when end_game? is false twice' do
      before do
        allow(new_game).to receive(:end_game?).and_return(false, false, true)
        choice = 1
        allow(new_game).to receive(:get_choice).and_return(choice)
        allow(new_game).to receive(:puts)
      end

      it 'calls update_board twice' do
        expect(new_game).to receive(:update_board).exactly(2).times
        new_game.play_round
      end
    end
  end

  describe '#get_choice' do
    subject(:game_input) { described_class.new }
    let(:player) { instance_double(Player, id: 1, name: 'Player 1')}

    before do
      allow(game_input).to receive(:puts).once
      choice = '1'
      allow(game_input).to receive(:gets).and_return(choice)
    end

    it 'sends the player\'s choice to verify_choice' do
      expect(game_input).to receive(:verify_choice).with('1')
      game_input.get_choice(player)
    end
  end

  describe '#verify_choice' do
    subject(:game_verify) { described_class.new }
    let(:player) { instance_double(Player, id: 1, name: 'Player 1') }

    context 'when user inputs valid value at an available space' do
      before do
        board = game_verify.instance_variable_get(:@board)
        board[0] = 'O'
      end

      it 'stops the loop and returns the value' do
        choice = '2'
        expect(game_verify).not_to receive(:gets)
        game_verify.verify_choice(choice)
      end
    end

    context 'when user inputs valid value at a space already taken' do
      before do
        board = game_verify.instance_variable_get(:@board)
        board[1] = 'X'
        allow(game_verify).to receive(:gets).and_return('3')
      end

      it 'completes the loop and displays \'space taken\' error message' do
        error_message = 'Space already taken. Please choose an available number from the spaces remaining.'
        choice = '2'
        expect(game_verify).to receive(:puts).with(error_message).once
        game_verify.verify_choice(choice)
      end
    end

    context 'when user inputs invalid values twice then a valid value' do
      before do
        valid_input = '3'
        high_num = '300'
        allow(game_verify).to receive(:gets).and_return(high_num, valid_input)
      end

      it 'completes loop and displays \'invalid input\' error message twice' do
        error_message = 'Invalid input. Please choose a number between 1-9:'
        letter = 'b'
        expect(game_verify).to receive(:puts).with(error_message).twice
        game_verify.verify_choice(letter)
      end
    end
  end

  describe '#update_board' do
    subject(:game_update) { described_class.new }
    
    context 'when player one makes a move' do
      let(:player_one) { instance_double(Player, id: 1, name: 'Player 1') }

      it 'puts an X in the chosen spot' do
        allow(game_update).to receive(:puts)
        player_token = 'X'
        board_position = 0
        choice = '1'
        board = game_update.instance_variable_get(:@board)
        expect { game_update.update_board(choice, player_one) }.to change { board[board_position] }.from(1).to(player_token)
      end

      it 'sends update_win_check' do
        allow(game_update).to receive(:puts)
        choice = 1
        board_position = 0
        expect(game_update).to receive(:update_win_check).with(board_position).once
        game_update.update_board(choice, player_one)
      end
    end

    context 'when player two makes a move' do
      let(:player_two) { instance_double(Player, id: 2, name: 'Player 2') }

      it 'puts an O in the chosen spot' do
        allow(game_update).to receive(:puts)
        player_token = 'O'
        board_position = 1
        choice = '2'
        board = game_update.instance_variable_get(:@board)
        expect { game_update.update_board(choice, player_two) }.to change { board[board_position] }.from(2).to(player_token)
      end
    end
  end

  describe '#update_win_check' do
    subject(:game_update_check) { described_class.new }

    context 'when a player chooses a spot' do
      let(:player_one) { instance_double(Player, id: 1, name: 'Player 1') }

      before do
        board = game_update_check.instance_variable_get(:@board)
        board[2] = 'X'
      end

      it 'updates the matching numbers in @win_check with the player\'s symbol' do
        choice_index = 2
        win_check = game_update_check.instance_variable_get(:@win_check)
        expect{ game_update_check.update_win_check(choice_index) }.to change { win_check.flatten.count('X') }.to(3)
        game_update_check.update_win_check(choice_index)
      end
    end
  end

  describe '#end_game?' do
    subject(:game_end) { described_class.new }

    context 'when a row has two X\'s and one O\'' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        win_check[0] = ['X', 'O', 'X']
      end

      it 'does not end the game' do
        expect(game_end).not_to be_end_game
      end

      it 'does not declare a winner' do
        expect{ game_end.end_game? }.not_to change { game_end.winner }
      end
    end

    context 'when the top row has all X\'s' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        win_check[0] = ['X', 'X', 'X']
      end

      it 'ends the game' do
        expect(game_end).to be_end_game
      end

      it 'declares the winner to be Player 1' do
        expect{ game_end.end_game? }.to change { game_end.winner }.to('Player 1')
      end
    end

    context 'when the top row has all O\'s' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        win_check[0] = ['O', 'O', 'O']
      end

      it 'ends the game' do
        expect(game_end).to be_end_game
      end

      it 'declares the winner to be Player 2' do
        expect{ game_end.end_game? }.to change { game_end.winner }.to('Player 2')
      end
    end

    context 'when the middle row has all O\'s' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        win_check[1] = ['O', 'O', 'O']
      end

      it 'ends the game' do
        expect(game_end).to be_end_game
      end

      it 'declares the winner to be Player 2' do
        expect{ game_end.end_game? }.to change { game_end.winner }.to('Player 2')
      end
    end

    context 'when a column has all O\'s' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        win_check[3] = ['O', 'O', 'O']
      end

      it 'ends the game' do
        expect(game_end).to be_end_game
      end

      it 'declares the winner to be Player 2' do
        expect{ game_end.end_game? }.to change { game_end.winner }.to('Player 2')
      end
    end

    context 'when a diagonal has all X\'s' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        win_check[3] = ['O', 'O', 'O']
      end

      it 'ends the game' do
        expect(game_end).to be_end_game
      end

      it 'declares the winner to be Player 2' do
        expect{ game_end.end_game? }.to change { game_end.winner }.to('Player 2')
      end
    end

    context 'when it\'s a stalemate (all spaces are full with no match of 3)' do
      before do
        win_check = game_end.instance_variable_get(:@win_check)
        i = 0
        8.times do
          win_check[i] = %w[X O X]
          i += 1
        end
      end

      it 'ends the game' do
        expect(game_end).to be_end_game
      end

      it 'declares the winner to be \'No one\'' do
        expect{ game_end.end_game? }.to change { game_end.winner }.to('No one')
      end
    end
  end
end