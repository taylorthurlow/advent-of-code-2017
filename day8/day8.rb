#!/usr/bin/env ruby

data = File.read('data.txt').chomp.split("\n")
r = /(\w+) (\w+) ([\d+-]+) if (\w+) ([<>=!]+) ([\d+-]+)/

# Part 1
regs = Hash.new 0

data.each do |instr|
  m = instr.match r
  next unless eval("#{regs[m[4].to_sym]} #{m[5]} #{m[6]}")
  eval("regs[:#{m[1]}] #{m[2] == 'inc' ? '+=' : '-='} #{m[3]}")
end

puts regs.values.max

# Part 2
regs = Hash.new 0
highest = -9999999999

data.each do |instr|
  m = instr.match r
  next unless eval("#{regs[m[4].to_sym]} #{m[5]} #{m[6]}")
  eval("regs[:#{m[1]}] #{m[2] == 'inc' ? '+=' : '-='} #{m[3]}")
  highest = [highest, regs.values.max].max
end

puts highest

