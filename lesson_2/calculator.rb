require "yaml"
require "pry"
MESSAGES = YAML.load(File.read("calculator_messages.yml"))

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i.to_s == num || num.to_f.to_s == num
end

def operation_to_message(op)
  word =  case op
          when '1'
            'Adding'
          when '2'
            'Subtracting'
          when '3'
            'Multiplying'
          when '4'
            'Dividing'
          end
  word
end

prompt(MESSAGES["welcome"])
name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES["name_error"])
  else
    break
  end
end
prompt("Hi #{name}!")

loop do
  number1 = ''
  loop do
    prompt(MESSAGES["get_first_number"])
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES["number_error"])
    end
  end
  number2 = ''
  loop do
    prompt(MESSAGES["get_second_number"])
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES["number_error"])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES["operator_error"])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

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

  prompt(MESSAGES["quit_or_go"])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
