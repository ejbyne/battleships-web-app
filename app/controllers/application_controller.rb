class BattleShips < Sinatra::Base

	set :views, Proc.new { File.join(root, "..", "views") }
  set :public_folder, Proc.new { File.join(root, "..", "..", "public") }
  set :raise_errors, false
  set :show_exceptions, false
  enable :sessions
  use Rack::Flash

  GAME = Game.new

  get '/reset' do
    GAME = Game.new
  end

  run! if app_file == $0

end
