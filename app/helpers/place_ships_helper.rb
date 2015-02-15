class BattleShips < Sinatra::Base

  def player_cell_rows
    player.board.convert_grid_values_to_rows
  end

  def other_player_cell_rows
    other_player.board.convert_grid_values_to_rows
  end

  def place_ship
    ship_choice = params[:ship]
    ship = create_ship(ship_choice)
    player.board.place(ship, (params[:column] + params[:row]), params[:orientation])
    session[ship_choice] = ship_choice
  end

  def create_ship(ship_choice)
    return Ship.aircraft_carrier if ship_choice == "aircraft_carrier"
    return Ship.battleship if ship_choice == "battleship"
    return Ship.destroyer if ship_choice == "destroyer"
    return Ship.submarine if ship_choice == "submarine"
    return Ship.patrol_boat if ship_choice == "patrol_boat"
  end

end
