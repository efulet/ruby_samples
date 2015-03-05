# You have two numbers represented by a linked list, where each node contains a 
# single digit. The digits are stored in reverse order, such that the 1's digit 
# is at the head of the list. Write a function that adds the two numbers and 
# returns the sum as a linked list

Node = Struct.new(:data, :next)

class LinkedList
  attr_accessor :head

  def initialize first_val=nil
    @head = Node.new(first_val) unless first_val.nil?
  end

  def add value
    if @head.nil?
      @head = Node.new(value)
    else
      current_node = @head
      while current_node.next do
        current_node = current_node.next
      end
      current_node.next = Node.new(value)
    end
  end
  
  def add_lists l1, l2
  
  end
  
  def to_s
    ll_to_str = []
    unless @head.nil?
      current_node = @head
      while current_node do
        ll_to_str << current_node.data
        current_node = current_node.next
      end
    end
    ll_to_str.join(' -> ')
  end
end

# Test cases
if __FILE__ == $0
  l1 = LinkedList.new 1
  l1.add 2
  l1.add 3
  puts l1.to_s
  
  
end
