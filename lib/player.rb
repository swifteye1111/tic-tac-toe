# frozen_string_literal: true

require_relative 'game'

# Player class keeps track of player ID
class Player
  @@num_players = 0
  attr_reader :name, :id

  def initialize
    @@num_players += 1
    @id = @@num_players
    @name = "Player #{id}"
  end
end