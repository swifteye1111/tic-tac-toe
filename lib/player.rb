# frozen_string_literal: true

require_relative 'game'

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