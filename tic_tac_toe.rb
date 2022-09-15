# frozen_string_literal: true

# Game class
class Game
  attr_accessor :board

  def initialize
    self.board = %w[1 2 3 4 5 6 7 8 9]
    self.run_game
  end

  def display_board
    game_display = ''
    self.board.each_with_index do |elm, i|
      game_display += elm
      if i == 2 || i == 5
        game_display += "\n--+---+--\n"
      elsif i != 8
        game_display += ' | '
      end
    end
    puts game_display
  end

  def run_game
    self.display_board
    @player1 = Player.new
    @player2 = Player.new
    self.play_round(@player1, @player2)
  end

  def play_round(p1, p2)
    self.update_board(self.get_choice(p1), p1)
    display_board
  end

  def get_choice(p)
    puts "#{p.name}: Please input a number from 1-9 that matches a space on the game board:"
    choice = gets.chomp
    until choice.to_i.between?(1, 9)
      puts 'Invalid input. Please choose a number between 1-9:'
      choice = gets.chomp
    end
    puts "Good job! You chose #{choice}!"
    choice
  end
  
  def update_board(choice, p)
    board[choice.to_i - 1] = p.id.odd? ? 'X' : 'O'
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

game = Game.new
