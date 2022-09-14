# class Game
# initialize a game board that's filled with spaces 1-9
# 1 | 2 | 3
# --+---+--
# 4 | 5 | 6
# --+---+--
# 7 | 8 | 9

def set_player_names
  puts "Please enter Player One's name:"
  #user1 = gets.chomp
  user1 = 'Player One'
  puts "Please enter Player Two's name:"
  #user2 = gets.chomp
  user2 = 'Player Two'
  [user1, user2]
end

def make_new_board
  %w[1 2 3 4 5 6 7 8 9]
end

def display_board(board)
  game_display = "\n"
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

current_board = make_new_board
display_board(current_board)

def get_choice(user)
  puts "#{user}: Please input a number from 1-9 that matches a space on the game board:"
  choice = gets.chomp
  until choice.to_i.between?(1, 9)
    puts 'Invalid input. Please choose a number between 1-9:'
    choice = gets.chomp
  end
  puts "Good job! You chose #{choice}!"
  choice
end

def update_board(choice, user, board)
  board[choice.to_i-1] = user.zero? ? 'X' : 'O'
  board
end

users = set_player_names
puts "Player One: #{users[0]}.\nPlayer Two: #{users[1]}."
choice = get_choice(users[0])
current_board = update_board(choice, 0, current_board)
display_board(current_board)
