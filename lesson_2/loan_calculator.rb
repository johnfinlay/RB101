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
  when "continue" then %w(y n yes no).include?(input.downcase)
  when "amount", "apr", "rate", "duration"
    input.to_f.to_s == input || input.to_i.to_s == input
  end
end

def fix_rate(num)
  if num.to_f > 1
    num.to_f / 100 / 12
  else
    num.to_f / 12
  end
end

prompt(MESSAGES["welcome"])

loop do
  amount = get_input("amount")
  apr = get_input("apr")
  rate = fix_rate(apr)
  duration = get_input("duration")

  prompt(MESSAGES["calculating"])

  monthly_payment = amount.to_f *
                    (rate / (1 - (1 + rate)**(duration.to_f * -12.0)))

  prompt("#{MESSAGES['result']} $#{format('%.2f', monthly_payment)}")

  answer = get_input("continue")
  break unless answer.downcase.start_with?('y')
  system "clear"
end

prompt(MESSAGES["exit"])
