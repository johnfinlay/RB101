require 'pry'
require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15]] +
                [[16, 17, 18, 19, 20], [21, 22, 23, 24, 25]] +
                [[1, 6, 11, 16, 21], [2, 7, 12, 17, 22], [3, 8, 13, 18, 23]] +
                [[4, 9, 14, 19, 24], [5, 10, 15, 20, 25]] +
                [[1, 7, 13, 19, 25], [5, 9, 13, 17, 21]]
def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength

def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}, Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  |  #{brd[4]}  |  #{brd[5]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[6]}  |  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  |  #{brd[10]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[11]}  |  #{brd[12]}  |  #{brd[13]}"\
       "  |  #{brd[14]}  |  #{brd[15]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[16]}  |  #{brd[17]}  |  #{brd[18]}"\
       "  |  #{brd[19]}  |  #{brd[20]}"
  puts "     |     |     |     |"
  puts "-----+-----+-----+-----+-----"
  puts "     |     |     |     |"
  puts "  #{brd[21]}  |  #{brd[22]}  |  #{brd[23]}"\
       "  |  #{brd[24]}  |  #{brd[25]}"
  puts "     |     |     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

def initialize_board
  new_board = {}
  (1..25).each { |num| new_board[num] = INITIAL_MARKER }
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
  squares = {}
  empty_squares(brd).each do |square|
    brd[square] = marker
    squares[square] = minimax(brd, 0, false, alternate_marker(marker))
    brd[square] = INITIAL_MARKER
    # binding.pry
  end
  squares.find { |_, v| v == squares.values.max }.first
end

def computer_chooses!(brd)
  brd[find_best_square(brd, COMPUTER_MARKER)] = COMPUTER_MARKER
end

def minimax(brd, depth, is_max, marker, alpha = -1000, beta = 1000)
  if winner?(brd)
    detect_winner(brd) == 'Player' ? (return -10 + depth) : (return 10 - depth)
  elsif board_full?(brd)
    return 0
  end
  max_depth = 6
  scores = is_max ? [-1000, 0] : [1000, 0]
  empty_squares(brd).each do |square|
    break if depth == max_depth
    brd[square] = marker
    marker = alternate_marker(marker)
    scores[1] = minimax(brd, depth + 1, !is_max, marker, alpha, beta)
    is_max ? (alpha = [alpha, scores[0]].max) : (beta = [beta, scores[0]].min)
    scores[0] = is_max ? scores.max : scores.min
    brd[square] = INITIAL_MARKER
    break if beta <= alpha
  end
  scores[0]
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 5
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 5
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
  answer
end

def place_piece!(brd, who)
  who == 'player' ? player_chooses!(brd) : computer_chooses!(brd)
end

def alternate_marker(marker)
  marker == 'X' ? 'O' : 'X'
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
