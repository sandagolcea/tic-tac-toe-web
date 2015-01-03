require_relative 'cell'

class Board
  attr_reader :size, :matrix

  def initialize(size=3)
    @size = size
    create_board(@size)
  end

  def create_board(size)
    @matrix = Array.new(size) {Array.new(size) {Cell.new}}
  end

  def empty?
    return false if @matrix.any? { |row| row.any? { |cell| (cell.state == "X" || cell.state == "0") } }
    true
  end

  def set(coord,player)
    x,y = translate(coord)
  
    return false if !valid_coordinates?(x,y)
    return false if cell_already_set?(x,y)

    @matrix[x][y].state = player.symbol
  end

  def full?
    return true if @matrix.all? { |row| row.all? { |cell| (cell.state == "X" || cell.state == "0") } }
    false
  end

  def game_over?(coord,player)
    x,y = translate(coord)
    
    return true if line_complete(x,player)
    return true if column_complete(y,player)
    
    # main diagonal
    if x == y 
      return true if diagonal_complete(player)
    end

    # secondary diagonal
    if x + y == @size - 1
      return true if second_diagonal_complete(player)
    end

    false
  end

  def display
    @matrix.each do |row|
      row.each { |elem| elem.state != nil ? (print " #{elem.state}") : (print " *") }
      puts
    end
  end

  private

    def translate(coord)
      # A1..A3, A1..C1
      array = coord.split(//)
      x = array.shift.ord - "A".ord
      y = array.join.to_i - 1
      [x,y]
    end

    def valid_coordinates?(x,y)
      return false if ( x < 0 || x >= @size || y < 0 || y >= @size )
      true
    end

    def cell_already_set?(x,y)
      return false if @matrix[x][y].state == nil
      true
    end

    def line_complete(x,player)
      check_array = 0
      0.upto(@size - 1) do |i|
        check_array += 1 if @matrix[x][i].state == player.symbol
      end
      check_array == @size
    end

    def column_complete(y,player)
      check_array = 0
      0.upto(@size - 1) do |i|
        check_array += 1 if @matrix[i][y].state == player.symbol
      end
      check_array == @size
    end

    # first diagonal check
    def diagonal_complete(player)  
      0.upto(@size - 1) do |i|
        return false if @matrix[i][i].state != player.symbol
      end
      true
    end

    # second diagonal check
    def second_diagonal_complete(player)
      0.upto(@size - 1) do |i|
        j = @size - 1 - i
        return false if @matrix[i][j].state != player.symbol
      end
      true
    end

end
