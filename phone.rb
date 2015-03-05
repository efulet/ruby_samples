# 

class Phone
  def initialize
    @numbers = (0..9).to_a
    @numbers_and_letters = (2..9).to_a
    @letters = ('A'..'Y').to_a - ['Q']
    @char_key = {}
    
    i = 0
    j = 2
    while i < @letters.length do
      @char_key[j] = [@letters[i], @letters[i+1], @letters[i+2]]
      i += 3
      j += 1
    end
  end
  
  def get_char_key key, place
    return nil if @char_key.empty?
    return nil unless @char_key.include?(key)
    
    @char_key[key][place-1]
  end
  
  # O(3^n)
  def print_phone_words phone
    result = Array.new
    if phone.is_a?(Array)
      do_print_phone_words phone, 0, result
    elsif phone.is_a?(Integer)
      do_print_phone_words phone.to_s.chars.map(&:to_i), 0, result
    else
      raise 'Not valid phone'
    end
  end
  
  def do_print_phone_words phone, cur, result
    if cur == @numbers_and_letters.length - 1
      puts result.join(',')
      return
    end
    
    for i in 1..3 do
      result[cur] = get_char_key(phone[cur], i)
      do_print_phone_words(phone, cur + 1, result)
      return if phone[cur] == 0 || phone[cur] == 1
    end
  end
  
  def non_r_print_phone_words phone
    raise 'Not valid phone' unless phone.is_a?(Integer)
    result = Array.new
    
    phone_to_arr = phone.to_s.chars.map(&:to_i)
    phone_number_lenght = @numbers_and_letters.length - 1
    
    for i in 0..phone_number_lenght
      result[i] = get_char_key(phone_to_arr[i], 1)
    end
    
    while true do
      phone_keys = ''
      for i in 0..phone_number_lenght
        phone_keys << result[i]
      end
      puts phone_keys
      phone_keys = ''
      
      for i in phone_number_lenght..-1
        return if i == -1
        
        if get_char_key(phone_to_arr[i], 3) == result[i] || phone_to_arr[i] == 0 || phone_to_arr[i] == 1
          result[i] = get_char_key(phone_to_arr[i], 1)
        elsif get_char_key(phone_to_arr[i], 1) == result[i]
          result[i] = get_char_key(phone_to_arr[i], 2)
          break
        elsif get_char_key(phone_to_arr[i], 2) == result[i]
          result[i] = get_char_key(phone_to_arr[i], 3)
          break
        end
      end
    end
  end
end

if __FILE__ == $0
  phone = Phone.new
  phone.print_phone_words(99448465)
  #puts ('=' * 80)
  #phone.non_r_print_phone_words(88967622)
end
