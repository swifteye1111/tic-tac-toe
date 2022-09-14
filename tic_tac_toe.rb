# class Game
# initialize a game board that's filled with spaces 1-9
# 1 | 2 | 3
# --+---+--
# 4 | 5 | 6
# --+---+--
# 7 | 8 | 9
game_arr = %w[1 2 3 4 5 6 7 8 9]
row_div = "\n--+---+--\n"
col_div = ' | '
game_display = ''
game_arr.each_with_index do |elm, i|
  game_display += elm
  if i == 2 || i == 5
    game_display += row_div
  elsif i != 8
    game_display += col_div
  end
end
puts "Please enter Player One's name:"
user1 = gets.chomp
puts "Player One's name is #{user1}."
puts "Please enter Player Two's name:"
user2 = gets.chomp
puts "Player Two's name is #{user2}."