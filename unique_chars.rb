# Implement an algorithm to determine if a string has all unique characters What 
# if you can not use additional data structures?

def is_unique_chars_2 str
  str_to_chars = str.split(//u)
  test_hash = {}
  
  str_to_chars.each do |c|
    return false if test_hash.include?(c)
    test_hash[c] = 1
  end
  
  true
end

# We can reduce our space usage a little bit by using a bit vector. We will 
# assume, in the below code, that the string is only lower case 'a' 
# through 'z'. This will allow us to use just a single int
def is_unique_chars str
  checker = 0
  
  str.each_char do |c|
    val = c[0] - 'a'[0]
    return false if (checker & (1 << val)) > 0
    checker |= (1 << val)
  end
  
  true
end

if __FILE__ == $0
  str = 'exequiel'
  puts "UniqueChars2(#{str}): #{is_unique_chars_2(str)}"
  puts "UniqueChars(#{str}): #{is_unique_chars(str)}"
  
  str = 'qwerty'
  puts "UniqueChars2(#{str}): #{is_unique_chars_2(str)}"
  puts "UniqueChars(#{str}): #{is_unique_chars(str)}"
end
