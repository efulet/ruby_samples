# Write an algorithm such that if an element in an MxN matrix is 0, its entire 
# row and column is set to 0
# Solution:
# At first glance, this problem seems easy: just iterate through the matrix and 
# every time we see a 0, set that row and column to 0 There's one problem with 
# that solution though: we will "recognize" those 0s later on in our iteration 
# and then set their row and column to zero Pretty soon, our entire matrix is 0s
# One way around this is to keep a second matrix which flags the 0 locations. 
# We would then do a second pass through the matrix to set the zeros This would 
# take O(MN) space.
# Do we really need O(MN) space? No Since we're going to set the entire row and 
# column to zero, do we really need to track which cell in a row is zero? No. 
# We only need to know that row 2, for example, has a zero.

def set_zeros matrix
  row = Array.new(matrix.size)
  column = Array.new(matrix[0].size)
  
  for i in 0...matrix.size do
    for j in 0...matrix[0].size do
      if matrix[i][j] == 0
        row[i] = 1
        column[j] = 1
      end
    end
  end
  
  for i in 0...matrix.size do
    for j in 0...matrix[0].size do
      matrix[i][j] = 0 if row[i] == 1 || column[j] == 1
    end
  end
  
  matrix
end

if __FILE__ == $0
  matrix = [[1,2,3],[4,0,6],[7,8,9]]
  
  puts "SetZeros(#{matrix.inspect}): #{set_zeros(matrix).inspect}"
end
