# Several char tests

# Write an efficient function to find the first nonrepeated character in a 
# string. For instance, the first nonrepeated character in "total" is 'o' 
# and the first nonrepeated character in "teeter" is 'r'. Discuss the 
# efficiency of your algorithm.
# O(n)
def first_non_repeated str
  char_hash = Hash.new
  str_to_arr = str.split('')
  
  str_to_arr.each do |c|
    if char_hash.include?(c)
      char_hash[c] = false
    else
      char_hash[c] = true
    end
  end
  
  str_to_arr.each do |c|
    return c if char_hash[c] == true
  end
  
  return nil
end

#￼Write an efficient function that deletes characters from a string where any 
# character existing in remove must be deleted from str. For example, given 
# a str of "Battle of the Vowels: Hawaii vs. Grozny" and a remove of "aeiou", 
# the function should transform str to “Bttl f th Vwls: Hw vs. Grzny”. 
# Justify any design decisions you make and discuss the efficiency of your 
# solution.
# O(nlogn)
def remove_chars str, remove
  temp = ''
  str.split('').each do |c|
    temp << c unless remove.include?(c)
  end
  
  return temp
end

#￼Write a function that reverses the order of the words in a string. For 
# example, your function should transform the string "Do or do not, there 
# is no try." to "try. no is there not, do or Do". Assume that all words 
# are space delimited and treat punctuation the same as letters.
def reverse_words str
  return str.split.reverse.join(' ')
end

def str_to_int str
  i = 1
  sum = 0
  negative = false
  char_to_digit = {'0'=> 0,'1'=>1,'2'=>2,'3'=>3,'4'=>4,'5'=>5,'6'=>6,'7'=>7,'8'=>8,'9'=>9}
  
  str_to_arr = str.split('')
  negative = true if str_to_arr[0] == '-'
  str_to_arr_l = str_to_arr.length
  
  str_to_arr.each do |c|
   if c != '-' && c != '.' && char_to_digit.include?(c)
     sum += char_to_digit[c] * (10 ** (str_to_arr_l-i))
   end
   
   i += 1
  end
  
  return (negative ? (-1 * sum) : sum)
end

def int_to_str myint
  digit_to_char = {0=>'0',1=>'1',2=>'2',3=>'3',4=>'4',5=>'5',6=>'6',7=>'7',8=>'8',9=>'9'}
  
  i = 0
  str = ''
  negative = false
  if myint < 0
    myint = -1 * myint
    negative = true
  end
  
  temp = myint
  
  while temp > 9 do
    temp = myint / (10 ** i)
    i += 1
  end
  
  if digit_to_char[temp]
    str += digit_to_char[temp]
    
    while i > 0
      temp = myint % (10 ** (i-1))
      c = (temp / (10 ** (i-2)))
      str += digit_to_char[c] if digit_to_char[c]
      i -= 1
    end 
  end
  
  return (negative ? '-' + str : str)
end

if __FILE__ == $0
  str = 'exequiel'
  puts "firstNonRepeated(#{str}): #{first_non_repeated(str)}"
  str = 'teeter' # is 'r'
  puts "firstNonRepeated(#{str}): #{first_non_repeated(str)}"
  str = 'Battle of the Vowels: Hawaii vs. Grozny'
  remove = 'aeiou'
  puts "removeChars(#{str}, #{remove}): #{remove_chars(str, remove)}"
  str = 'Do or do not, there is no try.'
  puts "reverseWords(#{str}): #{reverse_words(str)}"
  str = '367'
  puts "str_to_int('#{str}'): #{str_to_int(str)}"
  str = '-367'
  puts "str_to_int('#{str}'): #{str_to_int(str)}"
  myint = 732
  puts "int_to_str(#{myint}): '#{int_to_str(myint)}'"
  myint = -732
  puts "int_to_str(#{myint}): '#{int_to_str(myint)}'"
end
