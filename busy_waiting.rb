# Write a Producer thread and a Consumer thread that share a fixed-size buffer 
# and an index to access the buffer. The Producer should place numbers into the 
# buffer, while the Consumer should remove the numbers. The order in which the 
# numbers are added or removed is not important.

class IntBuffer
  require 'thread'
  
  BUFFER_SIZE = 8
  
  def initialize
    @index = 0
    @buffer = Array.new(BUFFER_SIZE)
    @mutex = Mutex.new
    @resource = ConditionVariable.new
  end
  
  def add num
    @mutex.synchronize do
      while @index == (@buffer.size - 1) do
        begin
          @resource.wait(@mutex)
        rescue => e
          puts "Error in IntBuffer class: #{e.message}"
        end
      end
      
      @buffer[@index] = num
      @index += 1
      @resource.signal
    end
  end
  
  def remove
    @mutex.synchronize do
      while @index == 0 do
        begin
          @resource.wait(@mutex)
        rescue => e
          puts "Error in IntBuffer class: #{e.message}"
        end
      end
      
      @index -= 1
      ret = @buffer[@index]
      @resource.signal
      return ret
    end
  end
end

class Producer
  require 'thread'
  
  def initialize buffer
    @buffer = buffer
    @semaphore = Mutex.new
  end
  
  def run
    p = Thread.new do
      @semaphore.synchronize do
        while true do
          begin
            num = rand(1000)
            @buffer.add num
            puts "Produced #{num}"
          rescue => e
            puts "Error in Producer class: #{e.message}"
          end
        end
      end
    end
    
    #p.join
  end
end

class Consumer
  require 'thread'
  
  def initialize buffer
    @buffer = buffer
    @semaphore = Mutex.new
  end
  
  def run
    c = Thread.new do
      @semaphore.synchronize do
        while true do
          begin
            num = @buffer.remove
            puts "Consumer #{num}"
          rescue => e
            puts "Error in Consumer class: #{e.message}"
          end
        end
      end
    end
    
    #c.join
  end
end

# Trying some examples
if __FILE__ == $0
  b = IntBuffer.new
  p = Producer.new b
  c = Consumer.new b
  
  p.run
  c.run
end
