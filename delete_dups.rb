# Write code to remove duplicates from an unsorted linked list
# FOLLOW UP
# How would you solve this problem if a temporary buffer is not allowed?

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
  
  # O(n)
  def delete_dups
    table = {}
    previous_node = nil
    current_node = @head
    
    while current_node do
      if table.include?(current_node.data)
        previous_node.next = current_node.next
      else
        table[current_node.data] = true
        previous_node = current_node
      end
      current_node = current_node.next
    end
  end
  
  # O(n^2)
  def delete_dups_2
    previous_node = @head
    current_node = previous_node.next
    while current_node do
      runner_node = @head
      while runner_node != current_node do
        if runner_node.data == current_node.data
          tmp = current_node.next
          previous_node.next = tmp
          current_node = tmp
          break
        end
        runner_node = runner_node.next
      end
      if runner_node == current_node
        previous_node = current_node
        current_node = current_node.next
      end
    end
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

if __FILE__ == $0
  linked_list = LinkedList.new 1
  linked_list.add 2
  linked_list.add 3
  
  puts linked_list.to_s
  
  linked_list.add 4
  linked_list.add 2
  linked_list.add 5
  puts linked_list.to_s
  linked_list.delete_dups
  puts linked_list.to_s
  linked_list.add 4
  linked_list.add 6
  puts linked_list.to_s
  linked_list.delete_dups_2
  puts linked_list.to_s
end
