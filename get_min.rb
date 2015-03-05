# Data design Issue to find insertion deletion and getMin in O(1)

Node = Struct.new(:value, :min, :next)

class LinkedList
  attr_accessor :head
  
  def initialize value=nil
    @head = Node.new(value, value, nil) if @head.nil?
  end
  
  # TODO
  def add value
    if @head.nil?
      @head = Node.new(value, value, nil)
    else
      current_node = @head
      #min = current_node.min
      #min = value if value < min
      
      while current_node.next do
        #current_node.min = min
        current_node = current_node.next
      end
      
      #current_node.min = min
      current_node.next = Node.new(value, min)
    end
  end
  
  def to_s
    ll_to_str = []
    unless @head.nil?
      current_node = @head
      while current_node do
        ll_to_str << "{#{current_node.value},#{current_node.min}}"
        current_node = current_node.next
      end
    end
    ll_to_str.join(' -> ')
  end
end

if __FILE__ == $0
  linked_list = LinkedList.new 7
  linked_list.add 3
  linked_list.add 1
  linked_list.add 5
  linked_list.add 2
  puts linked_list.to_s
  linked_list.add 6
  linked_list.add 7
  puts linked_list.to_s
  linked_list.add 0
  puts linked_list.to_s
end
