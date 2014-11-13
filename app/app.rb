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
    @player = Player.new
    @player.name = params[:player_name]
    GAME.add_player(@player)
    board = Board.new
    session[:me] = @player.object_id
    GAME.select_player_by_id(session[:me]).board = board
    redirect '/place_ships'
  end

  get '/place_ships' do
    @player = GAME.select_player_by_id(session[:me])
    @board = @player.board
    redirect '/game' if GAME.ready?
    redirect '/waiting' if @board.ship_count == 5
    @grid = @board.grid
    @rows = @grid.values.each_slice(10).to_a
    erb :place_ships
  end

  post '/place_ships' do
    @board = GAME.select_player_by_id(session[:me]).board
    ship_choice = params[:ship]
    ship = Ship.aircraft_carrier if ship_choice == "aircraft_carrier"
    ship = Ship.battleship if ship_choice == "battleship"
    ship = Ship.destroyer if ship_choice == "destroyer"
    ship = Ship.submarine if ship_choice == "submarine"
    ship = Ship.patrol_boat if ship_choice == "patrol_boat"
    @board.place(ship, (params[:column] + params[:row]).to_s, params[:orientation])
    redirect '/place_ships'
  end

  get '/waiting' do
    redirect '/game' if GAME.ready?
    erb :waiting
  end

  get '/game' do
    erb :game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
