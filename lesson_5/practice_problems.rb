# How would you order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']

arr.sort { |a, b| b.to_i <=> a.to_i }

# How would you order this array of hashes based on the year of publication of
# each book, from the earliest to the latest?

books = [
  { title: 'One Hundred Years of Solitude',
    author: 'Gabriel Garcia Marquez',
    published: '1967' },
  { title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    published: '1925' },
  { title: 'War and Peace',
    author: 'Leo Tolstoy',
    published: '1869' },
  { title: 'Ulysses',
    author: 'James Joyce',
    published: '1922' }
]

books.sort { |a, b| a[:published] <=> b[:published] }

# For each of these collection objects demonstrate how you would reference
# the letter 'g'.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

arr1[2][1][3]

arr2 = [{ first: ['a', 'b', 'c'], second: ['d', 'e', 'f']},
        { third: ['g', 'h', 'i'] }]

arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]

arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

hsh2[:third].keys.first

# For each of these collection objects where the value 3 occurs, demonstrate
# how you would change this to 4.

arr1 = [1, [2, 3], 4]

arr1[1][1] += 1
# p arr1

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

arr2[-1] += 1
# p arr2

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] += 1
# p hsh1

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][-1] += 1
# p hsh2

# Given this nested Hash:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# figure out the total age of just the male members of the family.
total = 0
munsters.each_value { |val| total += val['age'] if val['gender'] == 'male' }
# puts total

# One of the most frequently used real-world string properties is that of
# "string substitution", where we take a hard-coded string and modify it with
# various parameters from our program.

# Given this previously seen family hash, print out the name, age and gender of
# each family member:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# ...like this:

# (Name) is a (age)-year-old (male or female).

# munsters.each { |k, v| puts "#{k} is a #{v['age']}-year-old #{v['gender']}."}

# Given this code, what would be the final values of a and b? Try to work
# this out without running the code.

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

a == 2
b == [3, 8]

# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}
x = []
hsh.each do |_, v|
  v.each do |word|
    word.chars.each { |letter| x << letter if %w(a e i o u).include?(letter) }
  end
end

# p x

# Given this data structure, return a new array of the same structure but with
# the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map { |sub_arr| sub_arr.sort! { |a, b| b <=> a } }

# Given the following data structure and without modifying the original array,
# use the map method to return a new array identical in structure to the original
# but where the value of each integer is incremented by 1.

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr2 = arr.map do |hsh|
  hsh.each do |key, value|
    # ???
  end
end
p arr
p arr2
