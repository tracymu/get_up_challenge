class Square
  attr_accessor :x, :y, :chess_name

  def initialize(x, y)
    @x = x
    @y = y
    # Name the square using the appropriate chess position.
    @chess_name = "#{(x+65).chr}#{y+1}"
  end 
end