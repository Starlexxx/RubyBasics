# frozen_string_literal: true

array = [0, 1]

loop do
  latest_num = array.last + array[-2]
  break unless latest_num < 100

  array.push latest_num
end

puts array
