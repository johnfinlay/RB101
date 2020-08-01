require 'pry'

CARD_SUITS = ['H', 'S', 'D', 'C']
CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def prompt(msg)
  puts "=> #{msg}"
end

def new_deck
  cards = []
  CARD_SUITS.each do |suit|
    CARD_VALUES.each do |value|
      cards << [suit, value]
    end
  end
  cards.shuffle!
end

def deal_card!(hand, deck)
  hand << deck.shift
end

def format_cards(cards)
  list = ""
  cards.each { |card| list << card[1] + card[0] + ' ' }
  list.strip
end

def display_hands(hands, hide_one = true)
  system 'clear'
  dealer_cards = hands[:dealer].map.with_index do |card, index|
    index == 0 && hide_one ? ['?', '?'] : card
  end
  prompt "Dealer Cards:"
  prompt format_cards(dealer_cards)
  prompt "Player Cards:"
  prompt format_cards(hands[:player])
end

def player_turn(hands, deck, player_score)
  loop do
    display_hands(hands)
    prompt "Your turn, hit or stay(h/s)?"
    choice = ''
    loop do
      choice = gets.chomp[0].downcase
      break if %w(h s).include?(choice)
      prompt "Invalid choice, try again"
    end
    deal_card!(hands[:player], deck) if choice == 'h'
    player_score = total(hands[:player])
    break if choice == 's' || busted?(player_score)
  end
  player_score
end

def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == 'A'
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
  end

  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def dealer_turn(cards, deck, dealer_score)
  loop do
    break if dealer_score >= 17 || busted?(dealer_score)
    deal_card!(cards, deck)
    dealer_score = total(cards)
  end
  dealer_score
end

def busted?(score)
  score > 21
end

def get_winner(dealer_score, player_score)
  if player_score > 21
    :player_busted
  elsif dealer_score > 21
    :dealer_busted
  elsif player_score < dealer_score
    :dealer
  elsif dealer_score < player_score
    :player
  else
    :tie
  end
end

def display_results(winner)
  case winner
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def display_score(dealer_score, player_score)
  prompt "The score is Dealer: #{dealer_score}"\
         " Player: #{player_score}"
end

def play_again?
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

prompt "Welcome to Twenty-One!"
loop do
  hands = {
    dealer: [],
    player: []
  }
  deck = new_deck

  2.times do
    deal_card!(hands[:dealer], deck)
    deal_card!(hands[:player], deck)
  end

  player_score = total(hands[:player])
  dealer_score = total(hands[:dealer])

  player_score = player_turn(hands, deck, player_score)
  dealer_score = dealer_turn(hands[:dealer], deck, dealer_score) unless busted?(player_score)
  display_hands(hands, false)
  display_score(dealer_score, player_score)
  display_results(get_winner(dealer_score, player_score))

  break unless play_again?
end

prompt "Thanks for playing! Bye!"
