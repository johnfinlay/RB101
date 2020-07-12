=begin
    1. Understand the problem
        Given a string, write a method 'palindrome_substrings'which returns
        all the substrings from a given string which are palindromes. Consider
        palindrome words case sensitive.
        
        Things to clarify:
          what is a substring?
          what is a palindrome?
          how to handle empty strings?
          how to handle numbers and/or symbols?

    2. Set up your test cases
          palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
          palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
          palindrome_substrings("palindrome") == []
          palindrome_substrings("") == []
    3. Describe your inputs, outputs, and data structures
          Inputs: A String
          Outputs: An Array of Strings
          Data Structures: An array of strings
    4. Describe your algorithm
          1. Break the string in to an array of words
          2. Iterate the array, deleting words that are not palindromes
          3. Return the array.
    5. Begin coding
=end

def substrings(str)
  result = []
  max_index = str.length - 2
  (0..max_index).each do |index|
    max_size = str.length - index
    (2..max_size).each do |size|
      result << str.slice(index, size)
    end
  end
  result
end

def palindrome_substrings(sentence)
  arr = substrings(sentence)
  result = []
  arr.each { |word| result << word if word.reverse == word }
  result
end

puts palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
puts palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
puts palindrome_substrings("palindrome") == []
puts palindrome_substrings("") == []