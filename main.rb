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

# puts new_board.squares.length

def next_squares(square)
  possible_moves = []
  possible_moves << Square.new(square.x+2,square.y+1)
  possible_moves << Square.new(square.x-2,square.y-1)
  possible_moves << Square.new(square.x+2,square.y-1)
  possible_moves << Square.new(square.x-2,square.y+1)
  possible_moves << Square.new(square.x-1,square.y+2)
  possible_moves << Square.new(square.x+1,square.y+2) 
  possible_moves << Square.new(square.x-1,square.y-2)
  possible_moves << Square.new(square.x+1,square.y-2)
  
  possible_moves.map! {|square| square.chess_name}
  
  # next have to make it so that possible moves doesn't include things that are off the board
  return possible_moves
end

puts next_squares(new_board.squares[0])