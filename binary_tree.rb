# A simple binary tree implemenatation

class BinaryTree
  include Enumerable
  
  attr_accessor :value, :left, :right
  
  def initialize value = nil
    @value = value
  end
  
  def each &block
    return if self.nil?
    
    self.left.each( &block ) if self.left
    yield self.value
    self.right.each( &block ) if self.right
  end
  
  def empty?
    self.value == nil ? true : false
  end
  
  def insert value
    return self.value = value if self.value == nil
    
    case self.value <=> value
    when 1
      @left = BinaryTree.new unless self.left
      self.left.insert value
    when -1, 0
      @right = BinaryTree.new unless self.right
      self.right.insert value
    end
  end
  
  def sorted_array_to_bt arr, from=0, to=nil
    to = arr.length if to == nil
    
    return nil if from > to
    
    mid = (from + to)/2
    
    self.value = arr[mid] if self.value == nil
    
    unless from == to
      @left = BinaryTree.new unless self.left
      self.left.sorted_array_to_bt arr, from, mid - 1
      
      self.right = BinaryTree.new unless self.right
      self.right.sorted_array_to_bt arr, mid + 1, to
    end
  end
  
  # Cases:
  # + If node has no children, we only have to remove node from the tree
  # + If node has a single child, we remove node and connect its parent to its 
  #   child
  # + If node has two children, we need to:
  #   - Find the smallest node that is larger than n, call it m
  #   - Remove m from the tree (if you have reached this case then m will 
  #     always have no left child, though I'll leave the proof to the reader), 
  #     so we apply one or the other of the above cases to do this
  #   - Replace the value of n with m
  def remove value
    return nil if self.value == nil
    
    if self.left == nil && self.right == nil
      self
    elsif self.left == nil && self.right
      self.right
    elsif self.left && self.right == nil
      self.left
    else
      node = _search value
      _replace_parent node
    end
  end
  
  def _search value
    return nil if self.nil?
    return self if self.value == value
     
    case self.value <=> value
    when -1, 0
      return self.right._search value
    when 1
      return self.left._search value
    end
  end
  
  def _replace_parent node
    node.value = _successor_value(node.right)
    node.right = _update(node.right)
    node
  end
  
  def _successor_value node
    unless node.left.nil?
      _successor_value node.left
    end
    node.value
  end
  
  def _update node
    unless node.left.nil?
      node.left = _update(node)
    end
    node.right
  end
  
  def find value
    return nil if self.nil?
    return true if self.value == value
    
    case self.value <=> value
    when -1, 0
      return true if self.right and self.right.find(value)
    when 1
      return true if self.left and self.left.find(value)
    end
    
    return false
  end
  
  def preorder a=[]
    return if self.value == nil
    a.push self.value
    self.left.preorder(a) if self.left
    self.right.preorder(a) if self.right
    return a.join(', ')
  end
  
  def preorder_non_recursive
    s, p = [], []
    s.push self
    
    while true do
      curr = s.pop
      break if curr == nil
      p.push curr.value
      n = curr.right
      s.push(n) if n != nil
      n = curr.left
      s.push(n) if n != nil
    end
    
    return p.join(', ')
  end
  
  def inorder a=[]
    return if self.value == nil
    self.left.preorder(a) if self.left
    a.push self.value
    self.right.preorder(a) if self.right
    return a.join(', ')
  end
  
  def postorder a=[]
    return if self.value == nil
    self.left.preorder(a) if self.left
    self.right.preorder(a) if self.right
    a.push self.value
    return a.join(', ')
  end
  
  def find_lowest_common_ancestor v1, v2
    curr = self
    
    while curr do
      v = curr.value
      
      if v > v1 and v > v2
        curr = curr.left
      elsif v < v1 and v < v2
        curr = curr.right
      else
        return curr.value
      end
    end
    
    return nil
  end
  
  def to_s
    tree_str = ''
    
    self.each do |v|
      tree_str += " #{v} "
    end
    
    tree_str
  end
  
  def print_tree indent=0
    return if self.value == nil
    
    puts "#{'-'*indent} #{self.value}"
    
    self.left.print_tree(indent) if self.left
    self.right.print_tree(indent+4) if self.right
  end
end

# Test the BinaryTree
if __FILE__ == $0
  tree = BinaryTree.new(5)
  puts tree.to_s
  puts 'Inserting 100'
  tree.insert 100
  puts tree.to_s
  puts 'Inserting 50'
  tree.insert 50
  puts 'Inserting 25'
  tree.insert 25
  puts tree.to_s
  puts 'Inserting 75'
  tree.insert 75
  tree.insert 150
  tree.insert 125
  tree.insert 110
  tree.insert 175
  puts tree.to_s
  tree.print_tree
  puts 'Finding 75'
  puts "find(75): #{tree.find(75)}"
  puts 'Finding 90'
  puts "find(90): #{tree.find(90)}"
  puts 'Finding 150'
  puts "find(1): #{tree.find(150)}"
  puts "Preorder: #{tree.preorder}"
  puts "Preorder non-recursive: #{tree.preorder_non_recursive}"
  puts "Inorder: #{tree.inorder}"
  puts "Postorder: #{tree.postorder}"
  puts "Lowest ancestor(125,175): #{tree.find_lowest_common_ancestor(125,175)}"
  
  tree = BinaryTree.new 3
  tree.insert 2
  tree.insert 1
  tree.insert 4
  puts tree.preorder
  
  tree = BinaryTree.new
  tree.sorted_array_to_bt [1,2,3,4]
  puts tree.preorder
  
  tree = BinaryTree.new 5
  tree.insert 2
  tree.insert 7
  tree.insert 1
  tree.insert 3
  puts tree.preorder
  tree.remove 2
  puts tree.preorder
end
