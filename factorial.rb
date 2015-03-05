# Factorial tests

class Factorial
  def initialize
    @mem_factorial = Hash.new
  end
  
  def m_factorial n
    return 1 if n == 0
    
    if @mem_factorial.include?(n-1)
      return n * @mem_factorial[n-1]
    else
      @mem_factorial[n-1] = m_factorial(n-1)
      return n * @mem_factorial[n-1]
    end
  end
  
  def self.recursive_factorial n
    return 1 if n == 0
    return n * factorial(n-1)
  end
  
  def self.factorial n
    fac = 1
    i = n
    while i > 1 do
      fac *= i
      i -= 1
    end
    
    return fac
  end
end

# From N items, you can choose K of those items. If order matters in the groups 
# you are making then you are choosing permutations. If order does not matter, 
# then you are choosing combinations. In cases larger than 1, there will always 
# be more permutations than combinations.
# nPk = n! / (n-k)!
# nCk = n! / ((n-k)! * k!)
# Ruby does this natively

#class Array
#  def my_permutation
#    return [self] if size < 2
#    perm = []
#    each { |e|
#      (self - [e]).my_permutation.each { |p|
#        perm << ([e] + p)
#      }
#    }
#    perm
#  end
#end

class String
  def my_permutation
    return [self] if self.length < 2
    ret = []
    0.upto(self.length - 1) do |n|
      #rest = self.split('')
      rest = self.split(//u) # for UTF-8 encoded strings
      picked = rest.delete_at(n)
      rest.join.my_permutation.each { |x| ret << picked + x }
    end
    ret
  end
  
  def my_combination
    return [self] if self.length < 2
    ret = []
    0.upto(self.length - 1) do |n|
      rest = self.split(//u) # for UTF-8 encoded strings
      rest.delete_at(n)
      ret << rest.join
    end
    ret.reverse!
  end
end

class MyMath
  def self.permute_str str
    str.split(//u).permutation.to_a
  end
  
  def self.my_permute str
    str.my_permutation
  end
  
  def self.combination_str str
    str.split(//u).combination(str.length-1).map(&:join)
  end
  
  def self.my_combination str
    str.my_combination
  end
end

if __FILE__ == $0
  fac = Factorial.new
  
  start_time = Time.now
  0.upto(10).each do |n|
    puts "factorial(#{n})= #{Factorial.recursive_factorial(n)}"
    #Factorial.recursive_factorial(n)
  end
  puts "Recursive factorial fuction time= #{Time.now - start_time}"
  
  start_time = Time.now
  0.upto(10).each do |n|
    puts "factorial(#{n})= #{Factorial.factorial(n)}"
    #Factorial.factorial(n)
  end
  puts "Non-recursive factorial fuction time= #{Time.now - start_time}"
  
  start_time = Time.now
  0.upto(10).each do |n|
    puts "factorial(#{n})= #{fac.m_factorial(n)}"
    #fac.m_factorial(n)
  end
  puts "Mem factorial fuction time= #{Time.now - start_time}"
  
  str = 'abcd'
  puts "Permutation('#{str}'): #{MyMath.my_permute(str).join(', ')}"
  
  str = 'wxyz'
  puts "Combination('#{str}'): #{MyMath.combination_str(str).join(', ')}"
  puts "Combination('#{str}'): #{MyMath.my_combination(str).join(', ')}"
  str = '123'
  puts "Combination('#{str}'): #{MyMath.combination_str(str).join(', ')}"
  puts "Combination('#{str}'): #{MyMath.my_combination(str).join(', ')}"
end
