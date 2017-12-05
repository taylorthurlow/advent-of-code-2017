#!/usr/bin/ruby

nums = File.read('data.txt').chomp.chars.map(&:to_i)

# PART ONE

sum = 0
nums.each.with_index do |num, i|
  sum += num if num == nums[(i + 1) % nums.length]
end
puts sum

# PART TWO

sum = 0
nums.each.with_index do |num, i|
  sum += num if num == nums[(i + nums.length / 2) % nums.length]
end
puts sum


# Code golf
ns=File.read('data.txt').chomp.chars.map(&:to_i)
p ns.select.with_index{|n,i|n==ns[(i+1)%ns.size]}.sum
p ns.select.with_index{|n,i|n==ns[(i+ns.size/2)%ns.size]}.sum
