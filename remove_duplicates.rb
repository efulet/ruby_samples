# Design an algorithm and write code to remove the duplicate characters in a 
# string without using any additional buffer NOTE: One or two additional 
# variables are fine An extra copy of the array is not
# Test cases:
# + String does not contain any duplicates, e g : abcd
# + String contains all duplicates, e g : aaaa
# + Null string
# + String with all continuous duplicates, e g : aaabbb
# + String with non-contiguous duplicate, e g : abababa

# Time complexity is O()
def remove_duplicates str
  return if str == nil || str.empty?
  return if str.size < 2
  
  
end

if __FILE__ == $0
  str = 'abcd'
  puts "RemoveDuplicates(#{str}): #{remove_duplicates(str)}"
  
  str = 'aaaa'
  puts "RemoveDuplicates(#{str}): #{remove_duplicates(str)}"
  
  str = nil
  puts "RemoveDuplicates(#{str}): #{remove_duplicates(str)}"
  
  str = 'aaabbb'
  puts "RemoveDuplicates(#{str}): #{remove_duplicates(str)}
  
  str = 'ababab'
  puts "RemoveDuplicates(#{str}): #{remove_duplicates(str)}
end
