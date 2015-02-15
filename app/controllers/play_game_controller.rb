class BattleShips < Sinatra::Base

  get '/game' do
    redirect '/results' if GAME.won?
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
