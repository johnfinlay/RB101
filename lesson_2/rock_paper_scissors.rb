VALID_CHOICES = {
  'r' => 'rock',
  'p' => 'paper',
  'sc' => 'scissors',
  'l' => 'lizard',
  'sp' => 'spock'
}

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
  when 'player' then prompt("You won!")
  when 'computer' then prompt("Computer won!")
  else prompt("It's a tie!")
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
loop do
  players[:computer][:score] = 0
  players[:player][:score] = 0

  loop do
    loop do
      prompt("Choose one: rock(r), paper(p), "\
        "scissors(sc), lizard(l), spock(sp)")
      players[:player][:choice] = gets.chomp.downcase

      break if VALID_CHOICES.keys.include?(players[:player][:choice])
      prompt("That's not a valid choice.")
    end

    players[:computer][:choice] = VALID_CHOICES.keys.sample

    prompt("You chose: #{VALID_CHOICES[players[:player][:choice]]}; "\
      "Computer chose: #{VALID_CHOICES[players[:computer][:choice]]}")
    result = get_result(players[:player][:choice], players[:computer][:choice])
    display_results(result)
    update_score(players, result)

    if players[:computer][:score] == 5
      prompt("Computer won the match!")
      break
    elsif players[:player][:score] == 5
      prompt("You won the match!")
      break
    else
      prompt("The score is now you: #{players[:player][:score]}, "\
        "computer: #{players[:computer][:score]}\n\n")
    end
  end

  prompt("Would you like to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
