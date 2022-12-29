# frozen_string_literal: true

require_relative 'game'

# Player class keeps track of player ID
class Player
  attr_reader :name, :id

  def initialize(id)
    @id = id
    @name = "Player #{id}"
  end
end