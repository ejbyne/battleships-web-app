require 'sinatra/base'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/water'
require_relative '../lib/cell'
require_relative '../lib/ship'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "views") }
  enable :sessions

  GAME = Game.new

  get '/' do
    session[:game] = GAME
    erb :index 
  end

  post '/registration' do
    erb :registration
  end

  post '/new_player' do
    player = Player.new
    player.name = params[:player_name]
    GAME.add_player(player)
    board = Board.new
    session[:me] = player.object_id
    GAME.player_id(session[:me]).board = board
    # aircraft_carrier = Ship.aircraft_carrier
    # battleship = Ship.battleship
    # destroyer = Ship.destroyer
    # submarine = Ship.submarine
    # patrol_boat = Ship.patrol_boat
    redirect '/place_ships'
  end

  get '/place_ships' do
    @player = GAME.player_id(session[:me])
    @board = GAME.player_id(session[:me]).board
    puts @player
    puts @board
    puts session.inspect
    @grid = @board.grid
    @rows = @grid.values.each_slice(10).map{|row| row}
    @player.board = @board
    @rows = @grid.values.each_slice(10).map { |row| row }
    erb :place_ships
  end

  post '/place_ships' do
    puts params
    @board = GAME.player_id(session[:me]).board
    @aircraft_carrier = Ship.battleship
    @board.place(@aircraft_carrier, (params[:aircraft_carrier_row] + params[:aircraft_carrier_column]).to_sym, params[:aircraft_carrier_orientation])
    redirect '/place_ships'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
