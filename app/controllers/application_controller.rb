class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }
  set :public_folder, Proc.new { File.join(root, "..", "..", "public") }
  set :raise_errors, false
  set :show_exceptions, false
  enable :sessions
  use Rack::Flash

  GAME = Game.new

  error do
    flash[:notice] = env['sinatra.error'].message
    redirect '/' if already_two_players
    redirect '/place_ships' if invalid_placement
    redirect '/game' if invalid_shot
    session[:winner] = true if winner
    redirect '/results' if winner
  end

  get '/reset' do
    GAME = Game.new
  end

  run! if app_file == $0

end
