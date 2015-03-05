#!/usr/bin/env ruby

DICTIONARY_1 = [
  'exequiel',
  'is',
  'working',
  'on',
  'some',
  'examples'
]

DICTIONARY_2 = [
  'this',
  'text',
  'is',
  'short',
  'shorter'
]

DICTIONARY_3 = ['a', 'aa', 'aaa', 'ab' ]

##############

def break_into_spaces source, dic
  raise 'Missed source param' if source.empty? or source.nil?
  
  tmp_source = String.new(source)
  index = 1
  new_source = []
  new_dic = []
  
  while tmp_source.size > 0 do
    prefix = tmp_source[0, index]
    suffix = tmp_source[index, tmp_source.size]
    
    if dic.include?(prefix)
      new_source << prefix
      tmp_source = suffix
      index = 0
    end
    
    break if suffix.empty?
    
    if dic.include?(suffix)
      new_dic << prefix unless dic.include?(prefix)
      new_source << suffix
      break
    end
    
    index = index + 1
  end
 
  if new_source.empty?
    return "No words found using current dictionary for source '#{source}'"
  else
    msg = "Original: '#{source}' , New: '#{new_source.join(' ')}'"
    unless new_dic.empty?
      msg << ", Do we found new words?: '#{new_dic.join(', ')}'"
    end
    
    return msg
  end
end

def break_into_spaces_2 source, dic
  #raise 'Missed source param' if source.empty? or source.nil?
  
  return source if dic.include?(source)
  
  for i in 1..source.size do
    prefix = source[0, i]
    
    if dic.include?(prefix)
      suffix = source[i, source.size]
      
      seg_suffix = break_into_spaces_2(suffix, dic)
      return "#{prefix} #{seg_suffix}"
    end
  end
  
  return nil
end

# Examples:
puts break_into_spaces('qwerty', DICTIONARY_1)
puts break_into_spaces('holaexequiel', DICTIONARY_1)
puts break_into_spaces('exequielisworkingonsomeexamples', DICTIONARY_1)

puts break_into_spaces_2('holaexequiel', DICTIONARY_1)
puts break_into_spaces_2('exequielisworkingonsomeexamples', DICTIONARY_1)

puts break_into_spaces('thistextisshorter', DICTIONARY_2)
puts break_into_spaces_2('thistextisshorter', DICTIONARY_2)

puts break_into_spaces('aaab', DICTIONARY_3)
puts break_into_spaces_2('aaab', DICTIONARY_3)

