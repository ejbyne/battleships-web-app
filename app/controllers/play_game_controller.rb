class BattleShips < Sinatra::Base

  get '/game' do
    redirect '/results' if GAME.won?
    @player = GAME.select_player_by_id(session[:me])
    @rows = @player.board.convert_grid_values_to_rows
    @other_player = GAME.select_other_player_by_id(session[:me])
    @other_rows = @other_player.board.convert_grid_values_to_rows
    erb :game
  end

  post '/game' do
    fire_shot
    redirect '/game'
  end

  get '/results' do
    erb :results
  end

end
