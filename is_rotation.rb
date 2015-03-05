# Assume you have a method isSubstring which checks if one word is a substring 
# of another. Given two strings, s1 and s2, write code to check if s2 is a 
# rotation of s1 using only one call to isSubstring (i e , "waterbottle" is a 
# rotation of "erbottlewat")

def is_substring str, sub
  str.include?(sub)
end

def is_rotation s1, s2
  if s1.size == s2.size && s1.size > 0
    return is_substring(s1+s1, s2)
  end
  false
end

if __FILE__ == $0
  s1 = 'hello'
  s2 = 'world'
  puts (is_rotation(s1, s2))
  
  s1 = 'apple'
  s2 = 'pleap'
  puts (is_rotation(s1, s2))
  
  s2 = 'ppale'
  puts (is_rotation(s1, s2))
end
