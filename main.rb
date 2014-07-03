class Square
  attr_accessor :x, :y, :chess_name
  # Make a square at position x,y
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

new_board = Board.new(8,8)

def next_squares(square)
  possible_moves = []
  
  next_x_values = [2,-2,2,-2,-1,1,-1,1]
  next_y_values = [1,-1,-1,1,2,2,-2,-2]
  
  for i in (0..7)
    next_x = square.x + next_x_values[i]
    next_y = square.y + next_y_values[i]
    if next_x >=0 && next_y >=0
      possible_moves << Square.new(next_x,next_y)
    end
  end
  
  possible_moves.map! {|square| square.chess_name}
  
  return possible_moves 
end


puts next_squares(new_board.squares[28])




