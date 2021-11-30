# frozen_string_literal: true

puts 'Enter base'
base = gets.to_i

puts 'Enter height'
height = gets.to_i

result = 0.5 * base * height

if result.positive?
  puts result
else
  puts 'Wrong parameters'
end
