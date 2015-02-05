require 'sinatra/base'
require 'rack-flash'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/water'
require_relative '../lib/cell'
require_relative '../lib/ship'

class BattleShips < Sinatra::Base

  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "..", "public") }
  set :raise_errors, false
  set :show_exceptions, false
  enable :sessions
  use Rack::Flash

  GAME = Game.new

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

  get '/place_ships' do
    @player = GAME.select_player_by_id(session[:me])
    @rows = @player.board.grid.values.each_slice(10).to_a
    redirect '/game' if GAME.ready?
    redirect '/waiting' if @player.board.ship_count == 5
    erb :place_ships
  end

  post '/place_ships' do
    ship_choice = params[:ship]
    ship = Ship.aircraft_carrier if ship_choice == "aircraft_carrier"
    ship = Ship.battleship if ship_choice == "battleship"
    ship = Ship.destroyer if ship_choice == "destroyer"
    ship = Ship.submarine if ship_choice == "submarine"
    ship = Ship.patrol_boat if ship_choice == "patrol_boat"
    board = GAME.select_player_by_id(session[:me]).board
    board.place(ship, (params[:column] + params[:row]), params[:orientation])
    session[ship_choice] = ship_choice
    redirect '/place_ships'
  end

  get '/waiting' do
    redirect '/game' if GAME.ready?
    erb :waiting
  end

  get '/game' do
    redirect '/results' if GAME.won?
    @player = GAME.select_player_by_id(session[:me])
    @rows = @player.board.grid.values.each_slice(10).to_a
    @other_player = GAME.select_other_player_by_id(session[:me])
    @other_rows = @other_player.board.grid.values.each_slice(10).to_a
    erb :game
  end

  post '/game' do
    @other_player = GAME.select_other_player_by_id(session[:me])
    GAME.fire_at(params[:column] + params[:row])
    if @other_player.board.grid[(params[:column] + params[:row]).to_sym].content.is_a?(Ship)
      session[:hit?] = true
    else
      session[:hit?] = false
    end
    redirect '/game'
  end

  get '/results' do
    erb :results
  end

  get '/reset' do
    GAME = Game.new
  end

  error do
    if invalid_placement
      flash[:notice] = env['sinatra.error'].message
      redirect '/place_ships'
    elsif invalid_shot
      flash[:notice] = env['sinatra.error'].message
      redirect '/game'
    elsif winner
      session[:winner] = true
      redirect '/results'
    end
  end

  def invalid_placement
    env['sinatra.error'].message == 'You cannot place a ship outside of the grid' ||
      env['sinatra.error'].message == 'You cannot place a ship on another ship'
  end

  def invalid_shot
    env['sinatra.error'].message == 'No such coordinate' ||
      env['sinatra.error'].message == 'Already hit'
  end

  def winner
    env['sinatra.error'].message == 'Winner!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
