#!/usr/bin/ruby

class Program
  attr_accessor :name, :weight, :above
  def initialize(name, weight, above)
    @name = name
    @weight = weight
    @above = above
  end
end

programs = []
data = File.readlines('data.txt').map { |d| d.scan(%r{([a-z]+) \(([0-9]+)\)( -> ([a-z, ]+))?}).first }

data.each do |d|
  d.delete_at(2)
  d[2] = d[2].split(', ') unless d[2].nil?
  programs << Program.new(d[0], d[1].to_i, d[2])
end

# find the difference between the program list and the list of all child
# programs, this is guaranteed to be our root program
puts programs.map(&:name) - programs.map(&:above).flatten.compact.uniq
