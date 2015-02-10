class BattleShips < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/registration' do
    erb :registration
  end

  post '/new_player' do
    create_player_and_board
    redirect '/place_ships'
  end

end
