require 'pry'

CARD_SUITS = ['H', 'S', 'D', 'C']
CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

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

def display_hands(hands, hide_one = true)

end

def player_turn

end

def dealer_turn

end

def busted?(hand)

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

binding.pry

p hands
