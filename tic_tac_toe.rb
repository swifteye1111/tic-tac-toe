# class Game
# initialize a game board that's filled with spaces 1-9
# 1 | 2 | 3
# --+---+--
# 4 | 5 | 6
# --+---+--
# 7 | 8 | 9

puts "Please enter Player One's name:"
user1 = gets.chomp
puts "Player One's name is #{user1}."
puts "Please enter Player Two's name:"
user2 = gets.chomp
puts "Player Two's name is #{user2}."

def make_new_board
  %w[1 2 3 4 5 6 7 8 9]
end

def display_board(board)
  game_display = ''
  board.each_with_index do |elm, i|
    game_display += elm 
    if i == 2 || i == 5
      game_display += "\n--+---+--\n"
    elsif i != 8
      game_display += ' | '
    end
  end
  puts game_display
end

display_board(make_new_board)