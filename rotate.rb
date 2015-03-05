# Given an image represented by an NxN matrix, where each pixel in the image is 
# 4 bytes, write a method to rotate the image by 90 degrees Can you do this 
# in place?
#
# O(n^2) time and O(1) space algorithm
#
# + Rotate by +90:
#     1. Transpose
#     2. Reverse each row
# 
# + Rotate by -90:
#     1. Transpose
#     2. Reverse each column
#
# + Rotate by +180:
#     Method 1: Rotate by +90 twice
#     Method 2: Reverse each row and then reverse each column
#
# + Rotate by -180:
#     Method 1: Rotate by -90 twice
#     Method 2: Reverse each column and then reverse each row
#     Method 3: Reverse by +180 as they are same

class Array
  def rotate_90
    transpose.map(&:reverse)
  end
  
  def rotate_minus_90
    map(&:reverse).transpose
  end
  
  def rotate_180
    rotate_90.rotate_90
  end
  
  def rotate_minus_180
    rotate_minus_90.rotate_minus_90
  end
end

if __FILE__ == $0
  array = [[1,3,5],[2,4,6]]
  
  puts "Rotate 90 (#{array.inspect}): #{array.rotate_90.inspect}"
  puts "Rotate -90 (#{array.inspect}): #{array.rotate_minus_90.inspect}"
  puts "Rotate 180 (#{array.inspect}): #{array.rotate_180.inspect}"
  puts "Rotate -180 (#{array.inspect}): #{array.rotate_minus_180.inspect}"
end
