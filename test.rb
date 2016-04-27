class Hoge
  def who?
    puts self
    puts self.class

  end 
end 

h = Hoge.new
h.who?
