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

  get '/reset' do
    GAME = Game.new
  end

  run! if app_file == $0

end
