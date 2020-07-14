# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values are
# the positions in the array.
hash = {}
flintstones.each_with_index { |name, index| hash[name] = index }
# p hash

# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843,
  "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.sum

# In the age hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# remove people with age 100 and greater.

ages.delete_if { |key, value| value >= 100 }

ages

# Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.min

# In the array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Find the index of the first name that starts with "Be"

flintstones.find_index { |name| name.start_with?('Be') }

# Amend this array so that the names are all shortened to just the first three characters:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |name| name[0, 3] }

flintstones

# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

# ex:

# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

letters = {}
statement.chars.each do |letter|
  if letter != ' '
    if letters.include?(letter)
      letters[letter] += 1
    else
      letters[letter] = 1
    end
  end
end

letters

# What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  # p number
  numbers.shift(1)
end

# What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  # p number
  numbers.pop(1)
end

def titleize(str)
  str.split.map { |word| word.capitalize! }.join(' ')
end

words = "the flintstones rock"

titleize(words)

# Given the munsters hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below

answer = { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
  "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
  "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
  "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
  "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

#   Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

munsters.each do |key, value|
  if (0..17).include?(value["age"] )
    value["age_group"] = "kid"
  elsif (18..64).include?(value["age"] )
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end

munsters == answer
