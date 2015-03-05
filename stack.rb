# A simple stack using a linked list

Node = Struct.new(:value, :next)

class Stack
  attr_accessor :head
  
  def initialize value
    if value
      @head = Node.new(value, nil)
    else
      @head = nil
    end
  end
  
  def push value
    if @head.nil?
      @head = Node.new(value, nil)
    else
      @head = Node.new(value, @head)
    end
  end
  
  def pop
    return nil if @head.nil?
    old_head = @head
    @head = @head.next
    return old_head
  end
  
  def delete_stack
    while @head do
      current_node = @head
      @head = @head.next
      current_node = nil
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
    
    return nodes_str.empty? ? 'nil' : nodes_str
  end
end

if __FILE__ == $0
  stack = Stack.new(1)
  puts stack.to_s
  
  2.upto(10).each do |n|
    stack.push n
  end
  
  puts stack.to_s
  puts stack.pop.value.to_s
  puts stack.pop.value.to_s
  puts stack.to_s
  
  1.upto(5).each do |n|
    puts stack.pop.value.to_s
  end
  
  puts stack.to_s
  
  stack.delete_stack
  puts stack.to_s
end
