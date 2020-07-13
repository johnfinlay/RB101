VALID_CHOICES = {
  'r' => 'rock',
  'p' => 'paper',
  'sc' => 'scissors',
  'l' => 'lizard',
  'sp' => 'spock'
}

require "yaml"
MESSAGES = YAML.safe_load(File.read("rps_messages.yml"))

WINNERS = {
  'rock' => ['lizard', 'scissors'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['spock', 'paper'],
  'spock' => ['scissors', 'rock']
}

def win?(first, second)
  WINNERS[VALID_CHOICES[first]].include?(VALID_CHOICES[second])
end

def display_results(result)
  case result
  when 'player' then prompt(MESSAGES['you_won_game'])
  when 'computer' then prompt(MESSAGES['computer_won_game'])
  else prompt(MESSAGES['tie'])
  end
end

def get_result(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'tie'
  end
end

def update_score(players, result)
  case result
  when 'player' then players[:player][:score] += 1
  when 'computer' then players[:computer][:score] += 1
  end
end

def prompt(message)
  puts "=> #{message}"
end

def play_again?
  prompt(MESSAGES['play_again'])
  answer = ''
  loop do
    answer = gets.chomp
    break if %w(y n yes no).include?(answer.downcase)
    prompt(MESSAGES['invalid_play_again'])
  end
  %w(n no).include?(answer.downcase)
end

def player_chooses
  choice = ''
  loop do
    prompt(MESSAGES['choose'])
    choice = gets.chomp.downcase
    break if VALID_CHOICES.keys.include?(choice)
    prompt(MESSAGES['invalid_choice'])
  end
  choice
end

def get_winner(players)
  if players[:computer][:score] == 5
    "computer"
  elsif players[:player][:score] == 5
    "player"
  end
end

def display_winner(winner)
  case winner
  when "computer" then prompt(MESSAGES['computer_won_match'])
  when "player" then prompt(MESSAGES['you_won_match'])
  end
end

def display_score(players)
  prompt("#{MESSAGES['score_header']}#{players[:player][:score]}"\
    "       #{players[:computer][:score]}\n\n")
  prompt(MESSAGES['any_key'])
  gets.chomp
  system "clear"
end

players = {
  computer: {
    choice: '',
    score: 0
  },
  player: {
    choice: '',
    score: 0
  }
}

system "clear"
prompt(MESSAGES['welcome'])

loop do
  players[:computer][:score] = 0
  players[:player][:score] = 0
  loop do
    players[:player][:choice] = player_chooses
    players[:computer][:choice] = VALID_CHOICES.keys.sample
    prompt("You chose: #{VALID_CHOICES[players[:player][:choice]]}; "\
      "Computer chose: #{VALID_CHOICES[players[:computer][:choice]]}")
    result = get_result(players[:player][:choice], players[:computer][:choice])
    display_results(result)
    update_score(players, result)
    winner = get_winner(players)
    if winner
      display_winner(winner)
      break
    else
      display_score(players)
    end
  end

  break if play_again?
  system "clear"
end

prompt(MESSAGES['bye'])
