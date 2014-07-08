require_relative 'square'
require_relative 'board'
require 'sinatra'
require 'json'
require 'sinatra/flash'
require 'set'

enable :sessions

get '/' do
  erb :home
end

post '/results' do
  # Take the params as your inputs
  @start_square = params[:start_square].upcase
  @end_square = params[:end_square].upcase
  # Create a new board
  @new_board = Board.new(8,8)
  # Check if both inputs were on the board, and if so build paths.
  if check_input(@start_square, @end_square, @new_board)
    @path =  build_paths(@new_board, @start_square, @end_square)
    @path.to_json
  else
    flash[:error] = "Please only enter square names from a 8x8 board e.g. C3"  
    redirect '/'
  end
end

def squares_possible_moves(board)
  possible_moves = {}
  # The two arrays represent the possible moves in one plane.
  x_moves = [2,-2,2,-2,-1,1,-1,1]
  y_moves = [1,-1,-1,1,2,2,-2,-2]
  
  # Create a hash of the next possibilities for each square
  board.squares.each do |square|
    possible_moves[square] = []
    8.times do |i|
      next_x = square.x + x_moves[i-1]
      next_y = square.y + y_moves[i-1]
      if next_x.between?(0,board.max_x) && next_y.between?(0,board.max_y)
        possible_moves[square] << Square.new(next_x,next_y)
      end
    end
  end
  possible_moves
end

def check_input(start_square, end_square, board)
  chess_squares = Set[]
  board.squares.each do |square|
    chess_squares << square.chess_name
  end
  inputs = Set[start_square, end_square]
  # Check both those inputs are on the 8x8 board
  inputs.subset? chess_squares
end

def find_options(board, start_input)
  next_moves = squares_possible_moves(board)
  # Find the next square options for a particular square
  next_moves.each_key do |square| 
    if start_input == square.chess_name
       @options = next_moves[square]
    end
  end
  @options.map! {|square| square.chess_name}
end

def build_paths(board, start_square, end_square)
  all_paths =[]
  return all_paths if start_square == end_square
  # Find the next moves for the start_square
  options = find_options(board, start_square)
  (0..(options.length-1)).each do |i|
    all_paths[i]=[]
    if all_paths[i].include? options[i] or options[i] == end_square or all_paths[i].length > 6
      all_paths[i] << options[i]
    else
    # build_paths(board, options[i], end_square)
    # I wanted to use recursion here, but I couldn't make it work.
    # Maybe I needed another separate method to keep calling.
         
    # This code below is so I can at least have something to return. 
    # I realise it isn't an answer to the question.
      next_options = find_options(board, options[i])
      next_options.each do |j|
        all_paths[i]<< start_square + '-' + options[i] + '-' + j
      end
    end
  end
  return all_paths.sort_by {|path| path.length}
end
