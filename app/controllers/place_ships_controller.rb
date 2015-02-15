class BattleShips < Sinatra::Base

  get '/place_ships' do
    redirect '/game' if GAME.ready?
    redirect '/waiting' if player.board.ship_count == 5
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
