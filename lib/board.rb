class Board 

  attr_accessor :grid, :coords, :content
  attr_reader :letters, :numbers

  def initialize
    @grid = {}
    @coords = []
    @letters = [*'A'..'J']
    @numbers = [*1..10]
    gridded
  end

  def setting_coordinates
    @numbers.each do |number|
      @letters.each{|letter| @coords << letter + number.to_s }
    end
  end

  def gridded
    self.setting_coordinates
    @coords.each{|element| @grid[element.to_sym] = Cell.new(Water.new)}
  end

  def next_coord(coord, orientation)
    if orientation == 'vertical'
      coord[0] + coord[1].next
    elsif orientation == 'horizontal'
      coord.reverse.next.reverse
    end
  end

  def place(ship, coord, orientation)
    selected_coords = [coord]
    length = ship.length
    length -= 1
    length.times{selected_coords << next_coord(selected_coords.last, orientation)}
    raise_errors_if_cant_place_ship(selected_coords)
    selected_coords.each{ |key| grid[key.to_sym].content = ship }
  end

  def ships
    @grid.values.select{|coord| is_a_ship?(coord)}.map(&:content).uniq
  end

  def ship_count
    ships.count
  end

  def all_ships_sunk?
    ships.all?(&:sunk?)
  end

  def coord_in_grid(coord)
    coords.include?(coord)
  end

  def already_shot_at(coord)
    grid[coord.to_sym].shot_at?
  end

  def shoot(coord)
    raise "No such coordinate" if !coord_in_grid(coord)
    raise "Already hit" if already_shot_at(coord)
    grid[coord.to_sym].hit!
  end

  def is_a_ship?(coord)
    coord.content.respond_to?(:sunk?) 
  end

  def any_coord_not_on_grid?(selected_coords)
    (coords & selected_coords) != selected_coords
  end

  def any_coord_is_already_a_ship?(selected_coords)
    selected_coords.any? {|coord| is_a_ship?(grid[coord.to_sym])}
  end

  def raise_errors_if_cant_place_ship(selected_coords)
    raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(selected_coords)
    raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(selected_coords)
  end

end
