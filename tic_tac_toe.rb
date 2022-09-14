# frozen_string_literal: true

# Game class
class Game
  attr_accessor :board

  def initialize
    self.board = %w[1 2 3 4 5 6 7 8 9]
  end

end

# Player class
class Player
  def initialize(name)
    @name = name
  end
end

game = Game.new
puts game.board
player1 = Player.new('Josh')
player2 = Player.new('Jess')
