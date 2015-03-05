# A simple singly Linked List

Node = Struct.new(:value, :next)

class SinglyLinkedList
  attr_accessor :head
  
  def initialize(first_value=nil)
    @head = Node.new(first_value) if first_value
  end
  
  def add(value)
    if @head.nil?
      @head = Node.new(value)
    else
      current_node = @head
      while current_node.next
        current_node = current_node.next
      end
      current_node.next = Node.new(value)
    end
  end
  
  def find(value)
    current_node = @head
    while current_node != nil
      return current_node if current_node.value == value
      current_node = current_node.next
    end
    nil
  end
  
  def remove(value)
    if @head.value == value
      @head = @head.next
    else
      current_node = @head.next
      prev_node = @head
      while current_node
        if current_node.value == value
          prev_node.next = current_node.next
          return true
        end
        prev_node = current_node
        current_node = current_node.next
      end
      nil
    end
  end
  
  # Implement an algorithm to delete a node in the middle of a single linked 
  # list, given only access to that node
  # This problem cannot be solved if the node to be deleted is the last node 
  # in the linked list. That's OK, your interviewer wants to see you point 
  # that out. You could consider marking it as dummy in that case. This is an 
  # issue you should discuss with your interviewer
  def delete_node node
    return false if node == nil || node.next == nil
    
    next_node = node.next
    node.value = next_node.value
    node.next = next_node.next
    
    true
  end
  
  # 1. Create two pointers, p1 and p2, that point to the beginning of the node
  # 2. Increment p2 by n-1 positions, to make it point to the nth node from the 
  #    beginning (to make the distance of n between p1 and p2)
  # 3. Check for p2->next == null if yes return value of p1, otherwise increment 
  #    p1 and p2. If next of p2 is null it means p1 points to the nth node from 
  #    the last as the distance between the two is n
  # 4. Repeat Step 3
  def find_m_to_last(m=0)
    return nil if @head == nil || m < 1
    
    current_node = @head
    
    for i in 0...m do
      if current_node.next
        current_node = current_node.next
      else
        return nil
      end
    end
    
    m_behind = @head
    while current_node.next do
      current_node = current_node.next
      m_behind = m_behind.next
    end
    
    m_behind
  end
  
  # Takes a pointer to the head of a linked list and determines if
  # the list ends in a cycle or is NULL terminated
  def determine_termination
    fast, slow = @head
    
    while true do
      if fast or fast.next
        return false
      elsif fast == slow or fast == slow.next
        return true
      else
        slow = slow.next
        fast = fast.next.next
      end
    end
  end
  
  def to_s
    nodes_str = ''
    
    current_node = @head
    while current_node do
      nodes_str << current_node.value.to_s
      current_node = current_node.next
      nodes_str << ' -> ' if current_node
    end
    
    nodes_str.empty? ? 'nil' : nodes_str
  end
end

if __FILE__ == $0
  linked_list = SinglyLinkedList.new(1)
  puts linked_list.to_s
  
  2.upto(10).each do |n|
    linked_list.add n
  end
  puts linked_list.to_s
  
  linked_list.remove 5
  puts linked_list.to_s
  
  puts "f(mtolast)= #{linked_list.find_m_to_last(4).value}, m=4"
  
  puts "Linked List cyclic? #{linked_list.determine_termination}"
  
  linked_list.delete_node(linked_list.find(4))
  puts linked_list.to_s
end
