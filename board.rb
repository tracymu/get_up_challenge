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