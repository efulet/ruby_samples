#!/usr/bin/env ruby

# Write a program that prints the numbers from 1 to 100. But for multiples of 
# three print "Fizz" instead of the number and for the multiples of five print 
# "Buzz". For numbers which are multiples of both three and five print "FizzBuzz".

1.upto(100).each do |i|
  if i % 3 == 0 and i % 5 == 0
    puts 'FizzBuzz'
  elsif i % 3 == 0
    puts 'Fizz'
  elsif i % 5 == 0
    puts 'Buzz'
  else
    puts i
  end
end

(1..100).each { |i|
  x = ''
  x += 'Fizz' if i%3==0
  x += 'Buzz' if i%5==0
  puts(x.empty? ? i : x);
}

# Find the sum of all the multiples of 3 or 5 below 1000

i = 0
sum = 0
while i < 1000 do
  sum += i if i % 3 == 0 or i % 5 == 0
  i += 1
end
puts sum

