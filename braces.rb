# You're working with an intern that keeps coming to you with JavaScript code 
# that won't run because the braces, brackets, and parentheses are off. To 
# save you both some time, you decide to write a braces/brackets/parentheses 
# validator

@openers_to_closers_map = {
  '(' => ')',
  '{' => '}',
  '[' => ']'
}

@openers = @openers_to_closers_map.keys()
@closers = @openers_to_closers_map.values()

# Complexity:
# O(n) time (one iteration through the string), and O(n) space (in the worst 
# case, all of our characters are openers, so we push them all onto the stack)
def is_valid code
  raise 'Code string missed' if code == nil or code.empty?
  openers_stack = Array.new
  
  code_to_chars = code.split(//u)
  code_to_chars.each do |char|
    if @openers.include?(char)
      openers_stack.push char
    elsif @closers.include?(char)
      last_unclosed_opener = openers_stack.pop
      # if this closer doesn't correspond to the most recently seen unclosed 
      # opener, short-circuit, returning false
      return false unless @openers_to_closers_map[last_unclosed_opener] == char
    end
  end
  
  return openers_stack.empty?
end

if __FILE__ == $0
  puts is_valid("function method(param){return false;}")
  puts is_valid("function method(param{return false;}")
end
