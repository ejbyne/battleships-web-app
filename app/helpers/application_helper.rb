class BattleShips < Sinatra::Base

  def create_player_and_board
    player = Player.new
    board = Board.new(Cell, Water)
    player.name = params[:player_name]
    player.board = board
    GAME.add_player(player)
    session[:me] = player.object_id
  end

  def place_ship
    ship_choice = params[:ship]
    ship = Ship.aircraft_carrier if ship_choice == "aircraft_carrier"
    ship = Ship.battleship if ship_choice == "battleship"
    ship = Ship.destroyer if ship_choice == "destroyer"
    ship = Ship.submarine if ship_choice == "submarine"
    ship = Ship.patrol_boat if ship_choice == "patrol_boat"
    board = GAME.select_player_by_id(session[:me]).board
    board.place(ship, (params[:column] + params[:row]), params[:orientation])
    session[ship_choice] = ship_choice
  end

  def fire_shot
    other_player = GAME.select_other_player_by_id(session[:me])
    GAME.fire_at(params[:column] + params[:row])
    if other_player.board.grid[(params[:column] + params[:row]).to_sym].content.is_a?(Ship)
      session[:hit?] = true
    else
      session[:hit?] = false
    end
  end

  error do
    flash[:notice] = env['sinatra.error'].message
    if already_two_players
      redirect '/'
    elsif invalid_placement
      redirect '/place_ships'
    elsif invalid_shot
      redirect '/game'
    elsif winner
      session[:winner] = true
      redirect '/results'
    end
  end

  def already_two_players
    env['sinatra.error'].message == "The game already has two players"
  end

  def invalid_placement
    env['sinatra.error'].message == 'You cannot place a ship outside of the grid' ||
      env['sinatra.error'].message == 'You cannot place a ship on another ship'
  end

  def invalid_shot
    env['sinatra.error'].message == 'No such coordinate' ||
      env['sinatra.error'].message == 'Already hit'
  end

  def winner
    env['sinatra.error'].message == 'Winner!'
  end

end
