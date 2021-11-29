# frozen_string_literal: true

puts 'Enter your name'
name = gets.chomp.capitalize!

puts 'Enter your height'
height = gets

perfect_weight = (height.to_i - 110) * 1.15

if perfect_weight.positive?
  puts "#{name}, your perfect weight is #{perfect_weight}."
else
  puts 'Your weight is perfect already!'
end
