require_relative 'square'
require_relative 'board'

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

def squares_next_moves(board)
  @next_moves = {} 
  for square in board.squares
    @next_moves[square] = next_squares(square,board)
  end
  return @next_moves
end

def find_options(board, start_input)
  @start_input = start_input
  next_moves = squares_next_moves(board)
  next_moves.each_key do |square| 
    if start_input == square.chess_name
      return next_moves[square]
    end
  end
end

new_board = Board.new(8,8)

next_squares = find_options(new_board,'A3')

