require 'pry'
require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}, Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_chooses!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_best_square(brd, marker)
  choice = nil
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      choice = brd.select { |k, _| line.include?(k) }.key(INITIAL_MARKER)
      break
    end
  end
  choice
end

def computer_chooses!(brd)
  choice = find_best_square(brd, COMPUTER_MARKER)
  choice = find_best_square(brd, PLAYER_MARKER) unless !!choice
  choice = 5 unless !!choice || brd[5] != ' '
  choice = empty_squares(brd).sample unless !!choice
  brd[choice] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def joinor(arr, delimiter = ', ', last_delimiter = 'or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{last_delimiter} ")
  else
    arr[-1] = "#{last_delimiter} #{arr.last}"
    arr.join(delimiter)
  end
end

def display_score(hsh)
  prompt "Current score is Player: #{hsh['Player']}" \
         ", Computer: #{hsh['Computer']}"
  prompt "Press enter to continue..."
  gets.chomp
end

def champ(hsh)
  if hsh['Player'] == 5
    return 'Player'
  elsif hsh['Computer'] == 5
    return 'Computer'
  end
  nil
end

def who_goes_first
  prompt "Who should go first? (player, computer, random)"
  answer = ''
  loop do
    answer = gets.chomp
    break if %w(player computer random).include?(answer.downcase)
    prompt "Please enter a valid choice: player, computer, random"
  end
  answer = %w(player computer).sample if answer == 'random'
  return answer
end

def place_piece!(brd, who)
  who == 'player' ? player_chooses!(brd) : computer_chooses!(brd)
end

def alternate_player(who)
  who == 'player' ? 'computer' : 'player'
end

loop do
  scores = {
    'Player' => 0,
    'Computer' => 0
  }
  loop do
    current_player = who_goes_first
    board = initialize_board

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if winner?(board) || board_full?(board)
    end

    display_board(board)

    if winner?(board)
      winner = detect_winner(board)
      prompt "#{winner} won!"
      scores[winner] += 1
    else
      prompt "It's a tie!"
    end
    display_score(scores)
    break if !!champ(scores)
  end

  prompt "#{champ(scores)} wins the match!"
  prompt "Play again? (y or n)"
  answer = gets.chomp
  break if %(n).include?(answer.downcase[0])
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
