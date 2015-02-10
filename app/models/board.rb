class Board

  attr_reader :grid

  def initialize(cell_class, water_class)
    @grid = {}
    create_grid(cell_class, water_class)
  end
  
  def place(ship, coord, orientation)
    selected_coords = [coord]
    (ship.length-1).times { selected_coords << next_coord(selected_coords.last, orientation) }
    raise_errors_if_cant_place_ship(selected_coords)
    selected_coords.each { |coord| @grid[coord.to_sym].content = ship }
  end

  def shoot(coord)
    raise "No such coordinate" if any_coord_not_on_grid?([coord])
    raise "Already hit" if already_shot_at(coord)
    @grid[coord.to_sym].hit!
  end

  def ship_count
    ships.count
  end

  def all_ships_sunk?
    ships.all?(&:sunk?)
  end

  def convert_grid_values_to_rows
    @grid.values.each_slice(10).to_a
  end

private

  def create_grid(cell_class, water_class)
    (1..10).each do |number|
    	('A'..'J').each { |letter| @grid[(letter + number.to_s).to_sym] = cell_class.new(water_class) }
    end
  end

  def next_coord(coord, orientation)
  	orientation == 'vertical' ? coord.next : coord.reverse.next.reverse
  end

  def ships
    @grid.values.select { |cell| is_a_ship?(cell) }.map(&:content).uniq
  end

  def is_a_ship?(cell)
    cell.content.respond_to?(:sunk?)
  end

  def already_shot_at(coord)
    @grid[coord.to_sym].shot_at?
  end

  def any_coord_not_on_grid?(selected_coords)
    (@grid.keys.map(&:to_s) & selected_coords) != selected_coords
  end

  def any_coord_is_already_a_ship?(selected_coords)
    selected_coords.any? { |coord| is_a_ship?(@grid[coord.to_sym]) }
  end

  def raise_errors_if_cant_place_ship(selected_coords)
    raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(selected_coords)
    raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(selected_coords)
  end

end
