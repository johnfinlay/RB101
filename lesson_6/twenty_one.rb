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
  dealer_cards = hands[:dealer].map.with_index do |card, index|
    index == 0 && hide_one ? ['?', '?'] : card
  end
  prompt "Dealer Cards:"
  prompt format_cards(dealer_cards)
  prompt "Player Cards:"
  prompt format_cards(hands[:player])
end

def player_turn(hands)

end

def total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == 'A'
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def dealer_turn(cards)

end

def busted?(cards)

end

def get_winner(hands)

end

def display_results(hands)

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



display_hands(hands, false)
prompt "Dealer Total: #{total(hands[:dealer])}"
prompt "Player Total: #{total(hands[:player])}"
