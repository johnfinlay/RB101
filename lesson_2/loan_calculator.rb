require "yaml"
require "pry"
MESSAGES = YAML.load(File.read("loan_calculator_messages.yml"))

def prompt(message)
  puts "=> #{message}"
end

def get_input(input_type)
  loop do
    prompt(MESSAGES[input_type])
    data = gets.chomp
    case input_type
    when "welcome", "calculating", "result", "continue", "exit"
      return data
    else
      if data.to_i.to_s == data || data.to_f.to_s == data
        if data.to_f >= 0
          return data
        else
          prompt("No negative numbers please")
        end
      else
        prompt("Hmm... that doesn't look like a valid number")
      end
    end
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

  prompt("#{MESSAGES["result"]} $#{format('%.2f', monthly_payment)}")

  prompt(MESSAGES["continue"])
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES["exit"])

