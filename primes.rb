
def prime? n
  return false if n <=1
  return true if n == 2
  return false if n % 2 == 0
  
  m = Math.sqrt n
  i = 3
  
  while i <= m do
    return false if n % i == 0
    i += 2
  end
  
  return true
end

def sieve? n
  prime = Array.new(n) {true}
  
  prime[0], prime[1] = false, false
  
  m = Math.sqrt n
  
  for i in 2..m do
    if prime[i]
      k = i * i
      while k <= n do
        prime[k] =  false
        k += i
      end
    end
  end
  
  return prime
end

if __FILE__ == $0
  primes = []
  1.upto(100).each do |n|
    primes << n if prime?(n)
  end
  puts "Primes: #{primes.join(', ')}"
  
  puts "Sieve: #{sieve?(100).join(', ')}"
end
