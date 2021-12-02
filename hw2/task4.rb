# frozen_string_literal: true

require 'set'
vowels = {}
vowels_set = Set['a', 'e', 'i', 'o', 'u', 'y']
('a'..'z').each.with_index { |letter, i| vowels[letter.to_sym] = i + 1 if vowels_set.include? letter }

puts vowels
