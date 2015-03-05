#!/usr/bin/env ruby

# O(K^n)
def fib n
  return n if n < 2
  return fib(n-1) + fib(n-2)
end

# O(n)
def fib2 n
  i, j = 1, 0
  for k in 0..(n-1) do
    i, j = j, i + j
  end
  
  return j
end

# O(log(n))
def fib3 n
  return 0 if n <= 0
  
  i = n - 1
  a, b = 1, 0
  c, d = 0, 1
  
  while i > 0 do
    unless i % 2 == 0
      a, b = d*b + c*a, d*(b + a) + c*b
    end
    c, d = c**2 + d**2, d*(2*c + d)
    i = i / 2
  end
  
  return a + b
end

puts 'Recursive Fibonacci'
0.upto(10).each do |n|
  puts "fib(#{n})= #{fib(n)}"
end

puts 'Non-recursive Fibonacci'
0.upto(10).each do |n|
  puts "fib(#{n})= #{fib2(n)}"
end

puts 'Non-recursive Fibonacci 2 (O(log(n))'
0.upto(10).each do |n|
  puts "fib(#{n})= #{fib3(n)}"
end
