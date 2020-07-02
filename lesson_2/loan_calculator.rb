require "yaml"
require "pry"
MESSAGES = YAML.load(File.read("loan_calculator_messages.yml"))

def prompt(message)
  puts "=> #{message}"
end

def get_input(input_type)
  prompt(MESSAGES[input_type])
  input = ''
  loop do
    input = gets.chomp
    break if invalid_input?(input_type, input)
    prompt(MESSAGES["invalid_#{input_type}"])
  end
  input
end

def invalid_input?(input_type, input)
  case input_type
  when "continue" then invalid_continue?(input)
  when "amount" then invalid_amount?(input)
  when "apr" then invalid_apr?(input)
  when "duration" then invalid_duration?(input)
  end
end

def invalid_continue?(input)
  %w(y n yes no).include?(input.downcase)
end

def invalid_amount?(input)
  (input.to_f.to_s == input || input.to_i.to_s == input) && input.to_i > 0
end

def invalid_apr?(input)
  (input.to_f.to_s == input || input.to_i.to_s == input) && input.to_i > 0
end

def invalid_duration?(input)
  input.to_i.to_s == input && input.to_i > 0
end

def fix_rate(num)
  if num.to_f > 1
    num.to_f / 100 / 12
  else
    num.to_f / 12
  end
end

def calculate_monthly_payment(amount, rate, duration)
  amount.to_f * (rate / (1 - (1 + rate)**(duration.to_f * -12.0)))
end

prompt(MESSAGES["welcome"])

loop do
  amount = get_input("amount")
  apr = get_input("apr")
  rate = fix_rate(apr)
  duration = get_input("duration")

  prompt(MESSAGES["calculating"])

  monthly_payment = calculate_monthly_payment(amount, rate, duration)

  prompt("#{MESSAGES['result']} $#{format('%.2f', monthly_payment)}")

  answer = get_input("continue")
  break unless answer.downcase.start_with?('y')
  system "clear"
end

prompt(MESSAGES["exit"])
