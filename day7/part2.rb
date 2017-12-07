#!/usr/bin/ruby

# universal list of all programs
$all_programs = []

class Program
  attr_accessor :name, :weight, :children
  def initialize(name, weight)
    @name = name
    @weight = weight
    @children = []
    $all_programs << self
  end

  # use our data set to create children programs recursively
  def create_children(data)
    children = data.select{ |d| d[0] == @name }.first[2]
    children.each do |child|
      child_data = data.select { |cd| cd[0] == child }.first
      new_child = Program.new(child_data[0], child_data[1].to_i)
      @children << new_child
      new_child.create_children(data)
    end if children
  end

  # recursively sum the weights of self and all child programs
  def weight_all
    return @weight + @children.map(&:weight_all).sum
  end

  # recursively sum the weights of each subtree and compare them
  def children_balanced?
    return true if @children.empty?
    return @children.map(&:weight_all).uniq.size == 1
  end
end

data = File.readlines('data.txt').map { |d| d.scan(%r{([a-z]+) \(([0-9]+)\)( -> ([a-z, ]+))?}).first }
data.each do |d|
  d.delete_at(2)
  d[2] = d[2].split(', ') unless d[2].nil?
end

# we already know the root from the previous part, so let's add it and compute/add all its children
Program.new('bpvhwhh', 60)
root = $all_programs.select { |prog| prog.name == 'bpvhwhh' }.first
root.create_children(data)

# this loop will look at all programs and tell us which don't have balanced children. there is ONE
# program which is improperly weighted, but depending on how far down the tree that program is, this
# loop will show us multiple programs out of balance. we can follow these down to the last one, and
# find which of it's children causes the problem.
$all_programs.each do |ap|
  unless ap.children_balanced?
    puts "'#{ap.name}' is not balanced, children: #{ap.children.map{|c|[c.name, c.weight_all]}}"
  end
end

# based on output, culprit is:
# tulwp (264) -> dygbnr, wufaj, oxcetg, gbfjjv, xnfpxnd, oxvjudn, anongb
# it should be 8 units lighter, 264-8 = 256
