class MagicString < String
  def +@
    upcase
  end

  def -@
    downcase
  end

  def ~
    # Do a ROT13 transformation - http://en.wikipedia.org/wiki/ROT13
    tr 'A-Za-z', 'N-ZA-Mn-za-m'
  end

  def to_proc
    Proc.new { self }
  end

  def to_a
    [self.reverse]
  end

  if RUBY_VERSION > "1.9.0"
    eval %{def !
      swapcase
    end}
  end
end

str = MagicString.new("This is my string!")
p +str                   # => "THIS IS MY STRING!"
p ~str                   # => "Guvf vf zl fgevat!"
p +~str                  # => "GUVF VF ZL FGEVAT!"
p %w{a b}.map &str       # => ["This is my string!", "This is my string!"]
p *str                   # => "!gnirts ym si sihT"

if RUBY_VERSION > "1.9.0"
  p !str                   # => "tHIS IS MY STRING!"
  p (not str)              # => "tHIS IS MY STRING!"
  p !(~str)                # => "gUVF VF ZL FGEVAT!"
end
