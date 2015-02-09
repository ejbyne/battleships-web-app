class BattleShips < Sinatra::Base

  get '/place_ships' do
    @player = GAME.select_player_by_id(session[:me])
    @rows = @player.board.grid.values.each_slice(10).to_a
    redirect '/game' if GAME.ready?
    redirect '/waiting' if @player.board.ship_count == 5
    erb :place_ships
  end

  post '/place_ships' do
    ship_choice = params[:ship]
    ship = Ship.aircraft_carrier if ship_choice == "aircraft_carrier"
    ship = Ship.battleship if ship_choice == "battleship"
    ship = Ship.destroyer if ship_choice == "destroyer"
    ship = Ship.submarine if ship_choice == "submarine"
    ship = Ship.patrol_boat if ship_choice == "patrol_boat"
    board = GAME.select_player_by_id(session[:me]).board
    board.place(ship, (params[:column] + params[:row]), params[:orientation])
    session[ship_choice] = ship_choice
    redirect '/place_ships'
  end

  get '/waiting' do
    redirect '/game' if GAME.ready?
    erb :waiting
  end

end
