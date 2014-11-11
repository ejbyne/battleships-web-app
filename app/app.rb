require 'sinatra/base'
require_relative '../lib/player'
require_relative '../lib/game'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "views") }
  
  GAME = Game.new

  get '/' do
    erb :index 
  end

  post '/registration' do
    erb :registration
  end

  post '/place_ships' do
    @player = Player.new
    @player.name = params[:player_name]
    @grid = { :A1 => '~', :A2 => 'X', :A3 => 'X', :B1 => '~', :B2 => '~', :B3 => '~', :C1 => '~', :C2 => 'X', :C3 => '~' }
    erb :place_ships
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
