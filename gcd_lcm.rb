# The greatest common divisor (GCD) of two numbers a and b is the greatest 
# number that divides evenly into both a and b.
# 

def gdc a, b
  return a if b == 0
  return gdc b, a % b
end

def lcm a, b
  return b * a / gdc(a,b)
end

if __FILE__ == $0
  puts "GCD(2336, 1314)= #{gdc(2336,1314)}"
  puts "LCM(2336, 1314)= #{lcm(2336,1314)}"
end
