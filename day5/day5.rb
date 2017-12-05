#!/usr/bin/ruby

# PART 1

data = File.read('data.txt').split("\n").map(&:to_i)
pointer = jumps = 0
until pointer < 0 || pointer >= data.count do
  jump_length = data[pointer]
  data[pointer] += 1
  pointer += jump_length
  jumps += 1
end

puts "Jumps: #{jumps}"


# PART 2

data = File.read('data.txt').split("\n").map(&:to_i)
pointer = jumps = 0
until pointer < 0 || pointer >= data.count do
  jump_length = data[pointer]
  data[pointer] += jump_length < 3 ? 1 : -1
  pointer += jump_length
  jumps += 1
end

puts "Jumps: #{jumps}"
