# Write a method to replace all spaces in a string with '%20'

def replace_fun str
  return str.gsub(/\s+/, '%20')
end

def replace_fun2 str
  tmp_str = ''
  str.each_char do |c|
    if c == ' '
      tmp_str << '%20'
    else
      tmp_str << c
    end
  end
  return tmp_str
end

if __FILE__ == $0
  str = 'hello world'
  puts "ReplaceSpaces(#{str}): #{replace_fun(str)}"
  puts "ReplaceSpaces2(#{str}): #{replace_fun2(str)}"
end
