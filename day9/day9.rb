#!/usr/bin/env ruby

# Part 1
data = File.read('data.txt').chomp
data = data.sub(/!./, '') while data.include? '!'
data = data.gsub(/<.*?>/, '').delete(',')

depth, score = 0, 0
data.each_char do |c|
  if c == '{'
    score += (depth += 1)
    next
  end
  depth -= 1
end

puts score

# Part 2
data = File.read('data.txt').chomp
data = data.sub(/!./, '') while data.include? '!'
puts data.scan(/<(.*?)>/).flatten.sum(&:count)
