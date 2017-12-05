#!/usr/bin/ruby

data = File.read('data.txt').split("\n").map { |d| d.strip.gsub(/\s+/, ',').split(',').map(&:to_i) }

# PART ONE

puts data.collect { |row| row.max - row.min }.sum


# PART TWO

results = []
data.each do |row|
	row.each do |num|
		found = false
		(row - [num]).each do |compare|
			larger = [num, compare].max
			smaller = [num, compare].min
			if larger % smaller == 0
				results << larger / smaller
				found = true
				break
			end
		end
		break if found
	end
end

puts results.sum
