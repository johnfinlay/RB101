def select_fruit(produce_hash)
  fruits = {}
  produce_hash.each do |product, category|
    fruits[product] = category if category == 'Fruit'
  end
  fruits
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}
