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
  attr_accessor :squares, :max_x, :max_y
  
  def initialize(rows, columns)
    @squares = []
    for i in 0..(columns-1)
      for j in 0..(rows-1)
        @squares << Square.new(i,j)
      end
    end
    
    @max_x = rows-1
    @max_y = columns-1
  end
end


def next_squares(square, board)
  possible_moves = [] 
  x_moves = [2,-2,2,-2,-1,1,-1,1]
  y_moves = [1,-1,-1,1,2,2,-2,-2]
  
  for i in (0..7) 
    next_x = square.x + x_moves[i]
    next_y = square.y + y_moves[i]    
    if next_x.between?(0,board.max_x) && next_y.between?(0,board.max_y)
      possible_moves << Square.new(next_x,next_y)
    end   
  end
  
  possible_moves.map! {|square| square.chess_name}
end

new_board = Board.new(8,8)

# puts next_squares(new_board.squares[62], new_board)

squares_next_moves = {}

for square in new_board.squares
  squares_next_moves[square] = next_squares(square,new_board)
end

puts squares_next_moves