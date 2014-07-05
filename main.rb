require_relative 'square'
require_relative 'board'
require 'sinatra'
require 'json'

get '/' do
  erb :home
end

post '/results' do
  @start_square = params[:start_square]
  @end_square = params[:end_square]
  @new_board = Board.new(8,8)
  @path =  build_paths(@new_board, @start_square, @end_square)
  # erb:results
  @path.to_json
end

get '/example.json' do
  content_type :json
  { :key1 => 'value1', :key2 => 'value2' }.to_json
end

def squares_possible_moves(board)
  possible_moves = {}
  x_moves = [2,-2,2,-2,-1,1,-1,1]
  y_moves = [1,-1,-1,1,2,2,-2,-2]
  for square in board.squares
    possible_moves[square] = []
    for i in (0..7) 
      next_x = square.x + x_moves[i]
      next_y = square.y + y_moves[i]
      if next_x.between?(0,board.max_x) && next_y.between?(0,board.max_y)
        possible_moves[square] << Square.new(next_x,next_y)
      end   
    end
  end    
  possible_moves
end

def find_options(board, start_input)
  next_moves = squares_possible_moves(board)
  next_moves.each_key do |square| 
    if start_input == square.chess_name
       options = next_moves[square]
    end
    # options.map! {|square| square.chess_name}
    return options
  end
end

def build_paths(board, start_square, end_square)
  all_paths = []
  options = find_options(board, start_square)
  for i in (0..options.length)
    all_paths[i]=[]
    all_paths[i] << options[i]
    if all_paths[i].include? options[i] or options[i].chess_name == end_square
    else
       build_paths(board, i.chess_name, end_square)
    end
  end 
  # This is returning something insane! Need to fix up what it returns
end






