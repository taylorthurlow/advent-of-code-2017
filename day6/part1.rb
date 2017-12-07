#!/usr/bin/ruby

data = File.read('data.txt').split.map(&:to_i)

# storage for all memory states so we can tell when we've introduced a duplicate state
states = [data.dup]

while states == states.uniq do                      # only loop when we don't have a duplicate state
  max_value = data.max
  start_index = data.find_index(max_value)          # get the first instance of the highest value
  add_to_each = max_value / (data.size - 1)         # calculate the amount we should give to all other elements

  # handle where the value of the max element is smaller than the number of elements we need to distribute to
  add_to_each = 1 if add_to_each == 0

  # set up a running total we can subtract from as we add
  distribute_pool = max_value

  data[start_index] = 0

  data.each_index do |i|
    next if distribute_pool == 0                    # don't bother continuing if we can't add anything

    # calculate the index because we don't want to start from index 0, but rather start_index
    index = (start_index + i + 1) % data.size

    # if we have enough to add to this value in our pool, do it, otherwise add what we have left
    # in the pool
    if distribute_pool >= add_to_each
      distribute_pool -= add_to_each
      data[index] += add_to_each
    else
      data[index] += distribute_pool
      distribute_pool = 0
    end
  end

  print '.'
  states << data.dup
end

puts "\nFinal Data: #{data}"
puts "States Count: #{states.count}"
puts "Redistributions Count: #{states.count - 1}"
