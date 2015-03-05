# Binary search tests

class BinarySearch
  def initialize value=nil
    @binary_array = Array.new
    if value.is_a?(Array)
      @binary_array = value
      @binary_array.sort! {|x, y| x <=> y}
    else
      self.insert value unless value.nil?
    end
  end
  
  def insert value
    if @binary_array.empty?
      @binary_array << value
    else
      @binary_array << value
      @binary_array.sort! {|x, y| x <=> y}
    end
  end
  
  def find_index value
    from = 0
    to = @binary_array.length - 1
    
    while from <= to do
      mid = (from + to) / 2
      
      if value < @binary_array[mid]
        to = mid - 1
      elsif value > @binary_array[mid]
        from = mid + 1
      else
        return mid
      end
    end
  end
  
  # O(logn)
  def recursive_find_index value, from=0, to=nil
    to = @binary_array.length - 1 if to == nil
    
    return nil if from < 0
    return nil if to > @binary_array.length
    return nil if from > to
    
    mid = (from + to) / 2
    
    if value < @binary_array[mid]
      return recursive_find_index value, from, mid - 1
    elsif value > @binary_array[mid]
      return recursive_find_index value, mid + 1, to
    else
      return mid
    end
  end
  
  def to_s
    @binary_array.join(', ')
  end
end

if __FILE__ == $0
  search = BinarySearch.new 5
  search.insert 2
  puts "Binary array= [#{search.to_s}]"
  
  search = BinarySearch.new [5, 6, 2, 8, 1, 3]
  puts "Binary array= [#{search.to_s}]"
  
  start_time = Time.now
  puts "Recursive Index(6): #{search.recursive_find_index(6)}"
  puts "Recursive find_index fuction time= #{Time.now - start_time}"
  
  start_time = Time.now
  puts "Non-Recursive Index(6): #{search.find_index(6)}"
  puts "Non-Recursive find_index fuction time= #{Time.now - start_time}"
  
  start_time = Time.now
  puts "Recursive Index(4): #{search.recursive_find_index(4)}"
  puts "Recursive find_index fuction time= #{Time.now - start_time}"
  
  start_time = Time.now
  puts "Non-Recursive Index(4): #{search.find_index(4)}"
  puts "Non-Recursive find_index fuction time= #{Time.now - start_time}"
end
