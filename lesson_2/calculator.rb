def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i != 0
end


prompt("Welcome to Calculator!")
number1 = ''
number2 = ''
operator = ''

loop do
  prompt("What's the first number?")
  number1 = gets.chomp

  if valid_number?(number1)
    break
  else
    prompt("Hmm... that doesn't look like a valid number")
  end
end

loop do
  prompt("What's the second number?")
  number2 = gets.chomp

  if valid_number?(number2)
    break
  else
    prompt "Hmm... that doesn't look like a valid number"
  end
end

prompt("What operation would you like to perform? 1) add 2) subtract
  3) multiply 4) divide")
operator = gets.chomp

result =  case operator
          when '1'
            number1.to_i + number2.to_i
          when '2'
            number1.to_i - number2.to_i
          when '3'
            number1.to_i * number2.to_i
          when '4'
            number1.to_f / number2.to_f
          end

prompt("The result is #{result}")
