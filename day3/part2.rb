#!/usr/bin/ruby

def matrix_next_highest(input)
  # determine the size of the matrix by finding the next highest perfect square root
  matrix_size = Math.sqrt(input).ceil
  matrix_size += 1 if matrix_size % 2 == 0            # make sure the matrix size is odd
  matrix = Array.new(matrix_size) do                  # initialize the matrix with zeros
    Array.new(matrix_size, 0)
  end

  steps = [:right, :up, :left, :down]                 # set up traversal order using directions
  step_num = 0
  row = col = (matrix_size - 1) / 2                   # calculate the start index
  matrix[row][col] = 1                                # base case, we always start with 1 in the center

  # loop through values that represent the number of "moves" as we populate the matrix. we always
  # move i times, TWICE. For the very last iteration, we move i times, THRICE, finishing the matrix.
  # For example, we move 1xRight, 1xUp, 2xLeft, 2xDown, 3xRight, 3xUp, 4xLeft, 4xDown, 4xRight, to form
  # a 5x5 matrix with values from 1-25.
  (1..matrix_size - 1).each do |i|                    # the number of times moved each iteration
    (i == matrix_size - 1 ? 3 : 2).times do           # the number of times that we move i times
      i.times do                                      # perform the moves
        col += 1 if steps[step_num] == :right
        row -= 1 if steps[step_num] == :up
        col -= 1 if steps[step_num] == :left
        row += 1 if steps[step_num] == :down

        values = []
        (-1..1).each do |j|                           # iterate through all adjacent values, being sure that
          (-1..1).each do |k|                         # we are checking the bounds of our matrix
            access_row = row + j
            access_col = col + k
            if !(j == 0 && k == 0) && access_row >= 0 && access_row < matrix_size && access_col >= 0 && access_col < matrix_size
              values << matrix[row + j][col + k]
            end
          end
        end

        sum = values.sum
        matrix[row][col] = sum                        # set the value in the matrix to the sum of the values
        return sum if sum > input                     # we found the answer, return and forget the rest
      end

      step_num = (step_num + 1) % steps.count         # to go the next movement step, essentially looping
                                                      # circularly around the direction array
    end
  end
end

input = 347991
p matrix_next_highest(input)
