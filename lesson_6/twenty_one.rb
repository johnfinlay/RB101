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

def player_turn(hands, deck)
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
    break if choice == 's' || busted?(hands[:player])
  end
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

def dealer_turn(cards, deck)
  loop do
    break if total(cards) >= 17 || busted?(cards)
    deal_card!(cards, deck)
  end
end

def busted?(cards)
  total(cards) > 21
end

def get_winner(hands)
  dealer_score = total(hands[:dealer])
  player_score = total(hands[:player])
  if player_score > 21 || player_score < dealer_score
    return :dealer unless dealer_score > 21
  elsif dealer_score > 21 || dealer_score < player_score
    return :player
  end
  nil
end

def display_results(winner)
  if !!winner
    prompt "#{winner.capitalize} wins!"
  else
    prompt "It's a tie!"
  end
end

def display_score(hands)
  prompt "The score is Dealer: #{total(hands[:dealer])}"\
         " Player: #{total(hands[:player])}"
end

hands = {
  dealer: [],
  player: []
}

deck = new_deck

2.times do
  deal_card!(hands[:dealer], deck)
  deal_card!(hands[:player], deck)
end

player_turn(hands, deck)
dealer_turn(hands[:dealer], deck) unless busted?(hands[:player])
display_hands(hands, false)
display_score(hands)
display_results(get_winner(hands))
