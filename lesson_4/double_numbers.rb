def double_numbers!(numbers)
  numbers.each_index { |index| numbers[index] *= 2 }
end

def double_odd_indices!(numbers)
  numbers.each_index { |index| numbers[index] *= 2 if index.odd? }
end

def multiply(numbers, multiplier)
  numbers.each_index { |index| numbers[index] *= multiplier }
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3)
# p my_numbers
