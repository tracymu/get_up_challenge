class Square
  attr_accessor :x, :y, :chess_name
  # Make a square at position x,y
  def initialize(x, y)
    @x = x
    @y = y
    @chess_name = "#{(x+65).chr}#{y+1}"
  end 
end