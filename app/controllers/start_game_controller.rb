class BattleShips < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/registration' do
    erb :registration
  end

  post '/new_player' do
    @player = Player.new
    @board = Board.new(Cell, Water)
    @player.name = params[:player_name]
    @player.board = @board
    GAME.add_player(@player)
    session[:me] = @player.object_id
    redirect '/place_ships'
  end

end
