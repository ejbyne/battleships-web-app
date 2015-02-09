class BattleShips < Sinatra::Base

  get '/game' do
    redirect '/results' if GAME.won?
    @player = GAME.select_player_by_id(session[:me])
    @rows = @player.board.grid.values.each_slice(10).to_a
    @other_player = GAME.select_other_player_by_id(session[:me])
    @other_rows = @other_player.board.grid.values.each_slice(10).to_a
    erb :game
  end

  post '/game' do
    @other_player = GAME.select_other_player_by_id(session[:me])
    GAME.fire_at(params[:column] + params[:row])
    if @other_player.board.grid[(params[:column] + params[:row]).to_sym].content.is_a?(Ship)
      session[:hit?] = true
    else
      session[:hit?] = false
    end
    redirect '/game'
  end

  get '/results' do
    erb :results
  end

end
