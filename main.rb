require_relative 'square'
require_relative 'board'
require 'sinatra'
require 'json'
require 'sinatra/flash'
require 'set'

enable :sessions

# I don't have experience making APIs
# I did read up on it, but in the time I had, I couldn't create it
# to my satisfaction. So instead, I created a html page to take
# start and end values.
get '/' do
  erb :home
end

# I did return the results in json
post '/results' do   
  @start_square = params[:start_square].upcase
  @end_square = params[:end_square].upcase
  @new_board = Board.new(8,8)   
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
  x_moves = [2,-2,2,-2,-1,1,-1,1]
  y_moves = [1,-1,-1,1,2,2,-2,-2]
  board.squares.each do |square|
    possible_moves[square] = []
    7.times do |i|
      next_x = square.x + x_moves[i]
      next_y = square.y + y_moves[i]
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
  inputs.subset? chess_squares
end

def find_options(board, start_input)
  next_moves = squares_possible_moves(board)
  next_moves.each_key do |square| 
    if start_input == square.chess_name
       @options = next_moves[square]
    end
  end
  @options.map! {|square| square.chess_name}
end

def iterate_through(board, start_square, end_square)
  # I wanted to create this new method to use recursively
end

def build_paths(board, start_square, end_square)
  all_paths =[]
  options = find_options(board, start_square)
   (0..(options.length-1)).each do |i|
    all_paths[i]=[]
    if all_paths[i].include? options[i] or options[i] == end_square or all_paths[i].length > 6
      all_paths[i] << options[i]
    else
      # I think recursion is needed, but this below is no good. 
      # build_paths(board, options[i], end_square)
           
      # This code below is so I can at least have something to return. 
      # I realise it isn't an answer to the question.
      next_options = find_options(board, options[i])
      next_options.each do |j|
        all_paths[i]<< start_square + '-' + options[i] + '-' + j
      end     
    end 
  end
  return all_paths
end
