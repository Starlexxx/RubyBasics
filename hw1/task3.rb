# frozen_string_literal: true

puts 'Enter a'
a = gets.to_i

puts 'Enter b'
b = gets.to_i

puts 'Enter c'
c = gets.to_i

discriminant = b**2 - 4 * a * c

if discriminant.positive?
  puts "D=#{discriminant}, x1=#{(-b + Math.sqrt(discriminant)) / 2 * a}, x2=#{(-b - Math.sqrt(discriminant)) / 2 * a}"
elsif discriminant.zero?
  puts "D = #{discriminant}, x = #{-b.to_f / 2 * a}"
elsif discriminant.negative?
  puts 'no solutions'
end
