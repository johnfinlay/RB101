VALID_CHOICES = %w(rock paper scissors lizard spock)
WINNERS = {
  'rock' => ['lizard', 'scissors'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard' => ['spock', 'paper'],
  'spock' => ['scissors', 'rock']
}
def win?(first, second)
  WINNERS[first].include?(second)
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
    prompt("Choose one: rock, paper, scissors, lizard, spock")
    choice = gets.chomp

    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Would you like to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
