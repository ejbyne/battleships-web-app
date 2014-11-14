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
    
    erb :index 
  end

  post '/registration' do
    erb :registration
  end

  post '/new_player' do
    @player = Player.new
    @player.name = params[:player_name]
    GAME.add_player(@player)
    @board = Board.new
    session[:me] = @player.object_id
    GAME.select_player_by_id(session[:me]).board = @board
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
      session[ship_choice] = ship_choice
      ship = Ship.aircraft_carrier if ship_choice == "aircraft_carrier"
      ship = Ship.battleship if ship_choice == "battleship"
      ship = Ship.destroyer if ship_choice == "destroyer"
      ship = Ship.submarine if ship_choice == "submarine"
      ship = Ship.patrol_boat if ship_choice == "patrol_boat"
      @board.place(ship, (params[:column] + params[:row]), params[:orientation])
      redirect '/place_ships'
  end

  get '/waiting' do
    redirect '/game' if GAME.ready?
    erb :waiting
  end

  get '/game' do
    redirect '/results' if GAME.won?
    @player = GAME.select_player_by_id(session[:me])
    @board = @player.board
    @grid = @board.grid
    @rows = @grid.values.each_slice(10).to_a
    @other_player = GAME.select_other_player_by_id(session[:me])
    @other_board = @other_player.board
    @other_grid = @other_board.grid
    @other_rows = @other_grid.values.each_slice(10).to_a
    erb :game
  end

  post '/game' do
    @other_player = GAME.select_other_player_by_id(session[:me])
    @other_board = @other_player.board
    @other_board.shoot(params[:column] + params[:row])
    if @other_board.grid[(params[:column] + params[:row]).to_sym].content.is_a?(Ship)
      session[:hit?] = true
    else
      session[:hit?] = false
    end
    GAME.switch_turn
    redirect '/game'
  end

  get '/results' do
    erb :results
  end

  get '/reset' do
    GAME = Game.new
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
