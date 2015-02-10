class BattleShips < Sinatra::Base

  get '/place_ships' do
    @player = GAME.select_player_by_id(session[:me])
    @rows = @player.board.convert_grid_values_to_rows
    redirect '/game' if GAME.ready?
    redirect '/waiting' if @player.board.ship_count == 5
    erb :place_ships
  end

  post '/place_ships' do
    place_ship
    redirect '/place_ships'
  end

  get '/waiting' do
    redirect '/game' if GAME.ready?
    erb :waiting
  end

end
