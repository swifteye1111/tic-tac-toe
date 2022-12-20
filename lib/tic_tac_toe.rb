# frozen_string_literal: true

# Game class
class Game
  attr_accessor :board, :win_check, :winner

  def initialize
    self.board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @win_check = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
                  [0, 4, 8], [2, 4, 6]]
  end

  def display_board
    game_display = ''
    board.each_with_index do |elm, i|
      game_display += elm.to_s
      if i == 2 || i == 5
        game_display += "\n--+---+--\n"
      elsif i != 8
        game_display += ' | '
      end
    end
    puts game_display
  end

  def run_game
    display_board
    @player1 = Player.new
    @player2 = Player.new
    play_round([@player1, @player2])
  end

  def play_round(players)
    i = 0
    until end_game?
      update_board(get_choice(players[i]), players[i])
      i = i.zero? ? 1 : 0
    end
    puts "#{winner} wins!"
  end

  def get_choice(p)
    puts "#{p.name}: Please input a number from 1-9 that matches a space on the game board:"
    choice = gets.chomp
    until choice.to_i.between?(1, 9)
      puts 'Invalid input. Please choose a number between 1-9:'
      choice = gets.chomp
    end
    choice
  end
  
  def update_board(choice, p)
    board[choice.to_i - 1] = p.id.odd? ? 'X' : 'O'
    update_win_check(choice.to_i - 1)
    display_board
  end

  def update_win_check(choice_index)
    win_check.each do |arr|
      arr.each_with_index do |elm, i|
        arr[i] = board[choice_index] if elm == choice_index
      end
    end
  end

  def end_game?
    if win_check.all? { |arr| arr.all? { |i| i.is_a?(String) } }
      self.winner = 'No one'
      return true
    else
      win_check.each do |arr|
        if arr.uniq.count == 1
          self.winner = arr[0] == 'X' ? @player1.name : @player2.name 
          return true
        end
      end
    end
    false
  end
end

# Player class
class Player
  @@num_players = 0
  attr_reader :name, :id

  def initialize
    @@num_players += 1
    @id = @@num_players
    # puts "Please enter Player #{@id}'s name:"
    # @name = gets.chomp
    @name = "Player #{id}"
  end
end

Game.new
