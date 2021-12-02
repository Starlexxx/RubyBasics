# frozen_string_literal: true

def leap?(year)
  return true if ((year % 400).zero? || year % 100 != 0) && (year % 4).zero?

  false
end

puts 'Enter year'
year = gets.chomp.to_i
puts 'Enter month'
month = gets.chomp.to_i
puts 'Enter day'
day = gets.chomp.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = 29 if leap?(year)

(0..month - 2).each { |i| day += months[i] }

puts day
