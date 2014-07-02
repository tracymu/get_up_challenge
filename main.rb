class Square
  attr_accessor :x, :y, :chess_name
  
  def initialize(x, y)
    @x = x
    @y = y
    @chess_name = "#{(x+65).chr}#{y+1}"
  end
  
end

class Board
  attr_accessor :squares
  
  def initialize(rows, columns)
    @squares = []
    for i in 0..(columns-1)
      for j in 0..(rows-1)
        @squares << Square.new(i,j)
      end
    end
  end

end

new_board = Board.new(2,2)

puts new_board.squares[0].chess_name