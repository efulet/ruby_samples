# The Dining Philosophers
# Five introspective and introverted philosophers are sitting at a circular 
# table. In front of each philosopher is a plate of food. A fork (or a 
# chopstick) lies between each philosopher, one by the philosopher’s left hand 
# and one by the right hand. A philosopher cannot eat until he or she has both 
# forks in hand. Forks are picked up one at a time. If a fork is unavailable, 
# the philosopher simply waits for the fork to be freed. When a philosopher 
# has two forks, he or she eats a few bites and then returns both forks to the 
# table. If a philosopher cannot obtain both forks for a long time, he or she 
# will starve. Is there an algorithm that will ensure that no philosophers 
# starve?

class Philosopher
  require 'thread'
  
  attr_accessor :philosopher_thread
  
  def initialize id, fork1, fork2, forks=[]
    @id = id
    @fork1 = fork1
    @fork2 = fork2
    @forks = forks
    @philosopher_thread = nil
    @mutex_1 = Mutex.new
    @mutex_2 = Mutex.new
  end
  
  def run
    @philosopher_thread = Thread.new do
      status "Ready to eat using forks #{@fork1} and #{@fork2}"
      pause # pause to let others get ready
      while true do
        status "Picking up fork #{@fork1}"
        
        @mutex_1.synchronize do
          @forks[@fork1]
          status "Picking up fork #{@fork2}"
          
          @mutex_2.synchronize do
            @forks[@fork2]
            status "Eating"
          end
        end
      end
    end
  end
  
  def pause
    begin
      sleep 2
    rescue => e
      # do nothing
    end
  end
  
  def status msg=''
    $stdout.puts "Philosopher #{@id}: #{msg}"
  end
end

class DiningPhilosophers
  def initialize num
    @forks = Array.new(num)
    @philosophers = Array.new(num)
    
    for i in 0...num
      @forks[i] = rand(num)
    end
    
    for i in 0...num
      # This comment line causes a deadlock
      #@philosophers[i] = Philosopher.new(i, i, (i+1) % num, @forks)
      
      fork1 = i
      fork2 = (i+1) % num
      if i == 0
        @philosophers[0] = Philosopher.new(0, fork2, fork1, @forks)
      else
        @philosophers[i] = Philosopher.new(i, fork1, fork2, @forks)
      end
    end
  end
  
  def start_eating
    @philosophers.each do |p|
      p.run
    end
    
    # Suspend the main thread until the first philosopher
    # stops eating, which will never happen -- this keeps
    # the simulation running indefinitely
    @philosophers[0].philosopher_thread.join
  end
end

if __FILE__ == $0
  begin
    #d = DiningPhilosophers.new(5)
    #d.start_eating
    $stdout.puts 'This is not working, I need to investigate the deadlock'
  rescue => e
    $stderr.puts e, *(e.backtrace)
  end
end
