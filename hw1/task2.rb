# frozen_string_literal: true

puts 'Enter base'
base = gets

puts 'Enter height'
height = gets

result = 0.5 * base.to_i * height.to_i

if result.positive?
  puts result
else
  puts 'Wrong parameters'
end
