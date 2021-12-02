# frozen_string_literal: true

puts 'Enter product name'
product = gets.chomp
shopping_busket = {}
while product != 'stop'
  puts 'Enter product\'s price'
  price = gets.chomp.to_i
  puts 'Enter amount'
  amount = gets.chomp.to_i
  shopping_busket[product.to_sym] = { price => amount }
  puts 'Enter product name'
  product = gets.chomp
end
puts shopping_busket
total = 0
shopping_busket.each do |product, info|
  info.each do |price, amount|
    puts "#{product} costs #{price * amount}", total += price * amount
  end
end
puts "total: #{total}"
