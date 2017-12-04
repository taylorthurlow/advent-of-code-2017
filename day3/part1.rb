#!/usr/bin/ruby

def spiral_matrix(input)
  # determine the size of the matrix by finding the next highest perfect square root
  matrix_size = Math.sqrt(input).ceil
  matrix_size += 1 if matrix_size % 2 == 0            # make sure the matrix size is odd
  matrix = Array.new(matrix_size) do                  # initialize the matrix with zeros
    Array.new(matrix_size, 0)
  end

  steps = [:right, :up, :left, :down]                 # set up traversal order using directions
  step_num = 0
  row = col = (matrix_size - 1) / 2                   # calculate the start index
  input_col = input_row = nil                         # vars for the final coordinates of our input value
  matrix[row][col] = 1                                # base case, we always start with 1 in the center
  counter = 2

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

        matrix[row][col] = counter                    # set the value in the matrix
        if counter == input                           # set the location of our input value if we found it
          input_col = col
          input_row = row
        end
        counter += 1                                  # increment the value to be placed in the next spot
      end

      step_num = (step_num + 1) % steps.count         # to go the next movement step, essentially looping
                                                      # circularly around the direction array
    end
  end

  if [input_col, input_row].any?(&:nil?)              # catch base case of a 1x1 matrix
    input_col = input_row = 0
  end

  return {
    matrix: matrix,
    input_col: input_col,
    input_row: input_row
  }
end

def manhattan_distance(matrix, row, col)
  start = (matrix.first.length - 1) / 2
  d_col = (col - start).abs                           # calc the column distance
  d_row = (row - start).abs                           # calc the row distance
  return d_col + d_row                                # add the differences to get the manhattan distance
end

input = 347991
result = spiral_matrix(input)
p manhattan_distance(result[:matrix], result[:input_row], result[:input_col])
