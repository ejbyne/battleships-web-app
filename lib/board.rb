# class Cell
# attr_accessor :content
# end

class Board 

  attr_accessor :grid, :coords, :content
  attr_reader :letters, :numbers

  def initialize
    @grid = {}
    @coords = []
    rows
    columns
    gridded
  end

  def rows
    @letters = [*'A'..'J']
  end

  def columns
    @numbers = [*1..10]
  end

  def setting_coordinates
    @letters.each do |letter|
      @numbers.each{|number| @coords << letter + number.to_s }
    end
  end

  def gridded
    self.setting_coordinates
    @coords.each{|element| @grid[element.to_sym] = Cell.new(Water.new)}
  end

  def next_coord(coord, orientation)
    if orientation == 'horizontal'
      coord.next
      elsif orientation == 'vertical'
      coord.reverse.next.reverse
    end
  end

  def place(ship, coord, orientation)
  coords = [coord]
    ship.length.times{coords << next_coord(coords.last, orientation)}
    coords.pop
    coords.each{ |key| grid[key.to_sym] = ship  }
  end

  def coord_in_grid(coord)
    coords.include?(coord)
  end

  def already_hit(coord)
    raise "You cannot hit the same square twice" if  grid[coord.to_s].hit?
  end

  def shoot(coord)
    if coord_in_grid(coord)
      if !already_hit(coord)
      grid[coord.to_sym] = hit!
    end
  end

  def ship_count
    @grid.values.count(cell.content == ship)
  end

  end
end
