def prompt(message)
  puts "=> #{message}"
end

def get_number
  loop do
    num = gets.chomp
    if num.to_i.to_s == num || num.to_f.to_s == num
      if num.to_f > 0
        return num
      else
        prompt("No negative numbers please")
      end
    else
      prompt("Hmm... that doesn't look like a valid number")
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

prompt("Welcome, let's calculate your loan payment!")
prompt("What is the amount of the loan?")
amount = get_number

prompt("What is the Annual Percentage Rate(APR)?")
apr = get_number
rate = fix_rate(apr)

prompt("What is the loan duration in years?")
duration = get_number

prompt("Calculating loan payment...")

monthly_payment = amount.to_f *
                  (rate / (1 - (1 + rate)**(duration.to_f * -12.0)))

prompt("Your payment is $#{monthly_payment.round(2)}")
