#!/usr/bin/ruby

# PART 1

valid = 0
File.read('data.txt').split("\n").each do |passphrase|
  words = passphrase.split(' ')
  next if words != words.uniq
  valid += 1
end
puts valid


# PART 2

valid = 0
File.read('data.txt').split("\n").each do |passphrase|
  words = passphrase.split(' ')
  char_arrays = words.map { |w| w.chars.sort }
  next if char_arrays != char_arrays.uniq
  valid += 1
end
puts valid


# Code golfing, could probably be a bit better somehow reading the data

p File.read('data.txt').split("\n").count{|p|a=p.split;a==a.uniq}
p File.read('data.txt').split("\n").count{|p|a=p.split.map{|w|w.chars.sort};a==a.uniq}
