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

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  puts "=> #{message}"
end

loop do
  choice = ''
  loop do
    prompt("Choose one: rock(r), paper(p), scissors(sc), lizard(l), spock(sp)")
    choice = gets.chomp

    break if VALID_CHOICES.keys.include?(choice)
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.keys.sample

  prompt("You chose: #{VALID_CHOICES[choice]}; "\
    "Computer chose: #{VALID_CHOICES[computer_choice]}")

  display_results(choice, computer_choice)

  prompt("Would you like to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
